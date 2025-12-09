#!/usr/bin/env ruby
# version.rb version 3.20 (for Chromebrew)

OPTIONS = %w[-h --help -j --json -u --update-package-files -v --verbose -vv]

if ARGV.include?('-h') || ARGV.include?('--help')
  abort <<~EOM
    Usage: ./version.rb [<package>] #{OPTIONS.to_s.gsub('"', '')}
    Example: ./version.rb abcde -v
    The <package> can contain '*': ./version.rb "xorg_*"
    If <package> is omitted, all packages will be processed.
    Passing --update-package-files or -u will try to update the version
    field in the package file.
    Passing --json or -j will only give json output.
    Passing --all or -a will output the versions of all packages, not just the outdated ones.
    Passing --verbose or -v will display verbose output.
    Passing -vv will display very verbose output.
  EOM
end

require 'fileutils'
require 'json'
require 'net/http'
require 'uri/http'

crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
# When invoked from crew, pwd is CREW_DEST_DIR, so crew_local_repo_root
# is empty.
crew_local_repo_root = '../' if crew_local_repo_root.to_s.empty?
require File.join(crew_local_repo_root, 'lib/color')
require File.join(crew_local_repo_root, 'lib/const')
require File.join(crew_local_repo_root, 'lib/convenience_functions')
require File.join(crew_local_repo_root, 'lib/package')
require File.join(crew_local_repo_root, 'lib/package_utils')
require File.join(crew_local_repo_root, 'lib/require_gem')
require_gem('cgi')
require_gem 'ruby-libversion', 'ruby_libversion'
require_gem('ptools')

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift File.join(crew_local_repo_root, 'lib')

UPDATE_PACKAGE_FILES = ARGV.include?('-u') || ARGV.include?('--update-package-files')
OUTPUT_JSON = ARGV.include?('-j') || ARGV.include?('--json')
OUTPUT_ALL = ARGV.include?('-a') || ARGV.include?('--all')
VERBOSE = ARGV.include?('-v') || ARGV.include?('--verbose') || ARGV.include?('-vv')
VERY_VERBOSE = ARGV.include?('-vv')
bc_updated = {}
@pkg_names = {}
updatable_pkg = {}
version_line_string = {}
versions_updated = {}
versions = []

# Some packages do not have upstream versions, often because they are internal chromebrew packages or because upstream doesn't have a versioning scheme.
NO_UPSTREAM_VERSION_PKGS = %w[clear_cache gdk_base hello_world_chromebrew ld_default xdg_base]

# Some packges aren't eligible to be automatically updated despite having upstream versions.
CREW_UPDATER_EXCLUDED_PKGS = Set[
  { pkg_name: 'glibc', comments: 'Requires manual update.' },
  { pkg_name: 'gpm', comments: 'Upstream is defunct.' },
  { pkg_name: 'linuxheaders', comments: 'Requires manual update.' },
  { pkg_name: 'pkg_config', comments: 'Upstream is abandoned.' },
  { pkg_name: 'ruby', comments: 'i686 needs building with GCC 14.' },
  { pkg_name: 'util_linux', comments: 'Needs to be built with CREW_KERNEL_VERSION=5.10. See https://github.com/util-linux/util-linux/issues/3763' }
].to_h { |h| [h[:pkg_name], h[:comments]] }

def get_version(name, homepage, source)
  anitya_id = get_anitya_id(name, homepage, @pkg.superclass.to_s)
  # We return nil if anitya_id cannot be determined.
  puts "anitya_id: #{anitya_id}" if VERBOSE
  if !anitya_id.nil?
    # Get the latest stable version of the package from anitya.
    json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/versions/?project_id=#{anitya_id}")))
    puts json if VERY_VERBOSE
    return json['latest_version'] if json['stable_versions'][0].nil?
    return json['stable_versions'][0]
  elsif !source.nil?
    # If anitya has failed, we have a variety of fallbacks as a last resort.
    source.sub!('www.', '')
    url = URI.parse(source)
    puts "source_url host is #{url.host}" if VERY_VERBOSE
    case url.host
    when 'github.com'
      github_fallback(url)
    when 'gitlab.com'
      gitlab_fallback(url)
    when 'downloads.sourceforge.net'
      sourceforge_fallback(url)
    when 'pagure.io'
      pagure_fallback(url)
    end
  end
end

def github_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 3

  repo = "#{url_parts[1]}/#{url_parts[2].delete_suffix('.git')}"
  puts "GitHub repo is #{repo}" if VERBOSE

  releases_json = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{repo}/releases/latest")))
  tags_json = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{repo}/tags")))

  # We check for the prescence of a message here because this will also gracefully handle rate limiting.
  if releases_json.include?('message') && (tags_json.empty? || tags_json.include?('message'))
    puts 'GitHub repo not found or no release/tag available.' if VERBOSE
    return
  end

  github_ver = releases_json['tag_name'].nil? ? tags_json[0]['name'] : releases_json['tag_name']
  puts "github_ver = #{github_ver}" if VERY_VERBOSE
  # Strip off any leading non-numeric characters.
  return github_ver.sub(/.*?(?=[0-9].)/im, '')
end

def gitlab_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 3

  repo = "#{url_parts[1]}/#{url_parts[2].delete_suffix('.git')}"
  redirect = Net::HTTP.get_response(URI("https://#{url.host}/#{repo}/-/releases/permalink/latest"))['location']

  if redirect == "https://#{url.host}/users/sign_in"
    puts 'GitLab repo not found.' if VERBOSE
  elsif redirect.nil?
    puts 'No releases available on GitLab repo.' if VERBOSE
  else
    gitlab_ver = redirect.split('/').last
    # puts "gitlab_ver = #{gitlab_ver}" if VERY_VERBOSE
    puts "gitlab_ver = #{gitlab_ver}"
    # Strip off any leading non-numeric characters.
    return gitlab_ver.sub(/.*?(?=[0-9].)/im, '')
  end
end

def sourceforge_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 3

  repo = url_parts[2]
  puts "Sourceforge repo is #{repo}" if VERBOSE

  response = Net::HTTP.get_response(URI("https://sourceforge.net/projects/#{repo}/best_release.json"))
  if response.code == '404'
    puts 'Sourceforge repo not found.' if VERBOSE
    return
  end

  json = JSON.parse(response.body)
  if json['release'].nil?
    puts 'No releases available on Sourceforge repo.' if VERBOSE
    return
  end

  # Remove any preceding path components and remove any extensions, with an additional pass to remove .tar in the case of .tar.gz
  best_release = File.basename(json['release']['filename'], '.*').delete_suffix('.tar')
  puts "best_release = #{best_release}" if VERY_VERBOSE
  # Strip off any leading non-numeric characters.
  return best_release.sub(/.*?(?=[0-9].)/im, '')
end

def pagure_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 2

  repo = url_parts[1]
  puts "Pagure repo is #{repo}" if VERBOSE

  json = JSON.parse(Net::HTTP.get(URI("https://pagure.io/api/0/#{repo}/git/tags")))
  if !json['error'].nil?
    puts 'Pagure repo not found.' if VERBOSE
  elsif json['total_tags'].zero?
    puts 'No tags available on Pagure repo.' if VERBOSE
  else
    pagure_ver = json['tags'][0]
    puts "pagure_ver = #{pagure_ver}" if VERY_VERBOSE
    # Strip off any leading non-numeric characters.
    return pagure_ver.sub(/.*?(?=[0-9].)/im, '')
  end
end

def get_anitya_id(name, homepage, buildsystem)
  # Ignore python pip and ruby gem packages with the Pip and RUBY buildsystems.
  return if %w[Pip RUBY].include?(buildsystem)

  # Change the name into something Anitya will prefer.
  original_name = name.dup
  # Remove any language-specific prefixes and build splitting suffixes.
  # Do not use 'name' since that changes @pkg.name.to_sym
  anitya_name = PackageUtils.get_clean_name(name)
  # If this package has a hardcoded mapping, use it.
  anitya_name = CREW_ANITYA_PACKAGE_NAME_MAPPINGS[name] if CREW_ANITYA_PACKAGE_NAME_MAPPINGS.include?(name)
  puts "anitya_name: #{anitya_name} #{"(instead of #{original_name})" if anitya_name != original_name}" if VERBOSE

  # Find out how many packages Anitya has with the provided name.
  puts "url is https://release-monitoring.org/api/v2/projects/?name=#{CGI.escape(anitya_name)}" if VERY_VERBOSE
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/projects/?name=#{CGI.escape(anitya_name)}")))
  puts json if VERY_VERBOSE
  number_of_packages = json['total_items']

  puts "number_of_packages = #{number_of_packages}" if VERY_VERBOSE
  if number_of_packages == 1 # We assume we have the right package, take the ID and move on.
    return json['items'][0]['id']
  elsif number_of_packages.zero? # Anitya either doesn't have this package, or has it under a different name.
    # The most likely scenario is that the correct name is the current one with underscores converted to dashes.
    # This is also currently the only scenario we handle here.
    return unless anitya_name.include?('_')

    anitya_name_candidate = anitya_name.tr('_', '-')
    if VERY_VERBOSE
      puts "No Anitya package found with #{anitya_name}. Attempting a new search with #{anitya_name_candidate}."
      puts "url is https://release-monitoring.org/api/v2/projects/?name=#{anitya_name_candidate}"
    end

    # We can just call ourselves, with no fear of infinite recursion because we replaced all the underscores.
    return get_anitya_id(anitya_name_candidate, homepage, buildsystem)
  else # Anitya has more than one package with this exact name.
    candidates = json['items']

    # We aren't interested in any packages with anitya ecosystems, as they are provided by language package managers, such as pip.
    # This is because Chromebrew does not repackage them (#7713), so they won't be what we're looking for.
    anitya_ecosystems = %w[crates.io maven npm pypi rubygems]
    # The only exception is if we're checking a Python package, in which case the pypi ecosystem is fine.
    anitya_ecosystems.delete('pypi') if buildsystem == 'Python'

    candidates.delete_if { |candidate| anitya_ecosystems.include?(candidate['ecosystem']) }
    # Anitya doesn't have a CPAN ecosystem: https://github.com/fedora-infra/anitya/tree/master/anitya/lib/ecosystems
    # If the candidate is from CPAN but isn't a Perl package, its not what we're looking for.
    candidates.delete_if { |candidate| candidate['backend'] == 'CPAN (perl)' && buildsystem != 'PERL' }

    if candidates.length == 1 # If there's only one candidate left, we're done.
      return candidates[0]['id']
    elsif candidates.empty? # The package we're looking for is provided by a language package manager.
      # We probably shouldn't be providing this package.
      return
    else # There are still multiple candidates left.
      # This is where things get a little uncertain.
      # We check if the homepage Anitya has matches ours, but this really only works for Github projects.
      # For other projects, there's a lot more opinion involved in choosing the exact homepage.
      # Nevertheless, its our best shot at this point.
      candidates.each do |candidate|
        # We assume there is only one candidate with the same name and homepage as their crew counterpart.
        # Even if there are multiple candidates with the same name and homepage, its probably fine to treat them as identical.
        # If it isn't fine to treat them as identical, something has gone horribly wrong.
        # Fuzzy match the homepages by stripping the scheme and www subdomains before checking for equality.
        package_homepage = homepage.sub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "package_homepage = #{package_homepage}" if VERY_VERBOSE
        anitya_homepage = candidate['homepage'].sub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "anitya_homepage = #{anitya_homepage}" if VERY_VERBOSE

        return candidate['id'] if package_homepage == anitya_homepage
      end
      puts 'No Anitya packages found.' if VERY_VERBOSE

      # If we're still here, that means none of the candidates had the same homepage as their crew counterpart.
      # Not much we can do at this point to find the version, and its better to be cautious to avoid getting the wrong candidate.
      return
    end
  end
end

# If we have been required from another file (i.e. for testing) don't run any of this, as we're only interested in the functions up above.
return if __FILE__ != $PROGRAM_NAME

filelist = []
# Handle multiple packages being passed to version.rb.
argv = ARGV.map(&:split).flatten
if argv.length.positive? && !(argv.length == 1 && OPTIONS.include?(argv[0]))
  argv.each do |arg|
    arg = arg.gsub('.rb', '')
    next unless arg =~ /^[0-9a-zA-Z_*]+$/
    if arg.include?('*')
      Dir[File.join(crew_local_repo_root, "packages/#{arg}.rb")].each do |filename|
        filelist.push filename
      end
    else
      filename = File.join(crew_local_repo_root, "packages/#{arg}.rb")
      filelist.push filename if File.exist?(filename)
    end
  end
else
  Dir[File.join(crew_local_repo_root, 'packages/*.rb')].each do |filename|
    filelist.push filename
  end
end

# Remove duplicates.
filelist.uniq!

if filelist.length.positive?
  max_pkg_name_length = File.basename(filelist.max_by(&:length)).length - 3
  package_field_length = [max_pkg_name_length, 7].max + 1
  status_field_length = 17
  version_field_length = 13

  puts "#{'Package'.ljust(package_field_length)}#{'Status'.ljust(status_field_length)}#{'Current'.ljust(version_field_length)}#{'Upstream'.ljust(version_field_length)}#{'Updatable?'.ljust(version_field_length)}Compile?" unless OUTPUT_JSON
  puts "#{'-------'.ljust(package_field_length)}#{'------'.ljust(status_field_length)}#{'-------'.ljust(version_field_length)}#{'--------'.ljust(version_field_length)}#{'----------'.ljust(version_field_length)}--------" unless OUTPUT_JSON
  filelist.each do |filename|
    @pkg = Package.load_package(filename)
    cleaned_pkg_version = PackageUtils.get_clean_version(@pkg.version)
    # Mark package file as updatable (i.e., the version field can be
    # updated in the package file) if the string "version" is on the
    # git_hashtag line or the string "#{version}" is on the source_url
    # line.
    updatable_pkg[@pkg.name.to_sym] = if @pkg.is_fake?
                                        'No'
                                      elsif @pkg.ignore_updater?
                                        if `grep '^  version' #{filename} | awk '{print $2}' | grep '\.version'`.empty?
                                          'ignore_updater set'
                                        else
                                          "version alias: #{`grep '^  version' #{filename} | awk '{print $2}'`.chomp}"
                                        end
                                      elsif @pkg.source_url.is_a?(Hash) || @pkg.source_url.include?('SKIP')
                                        'Yes'
                                      # If there is a git_hashtag, we can
                                      # check to see if 'version' is on
                                      # that line.
                                      elsif !@pkg.git_hashtag.blank?
                                        if `grep "^  git_hashtag" #{filename} | grep version`.empty? && @pkg.name != 'rust'
                                          'static git_hashtag'
                                        else
                                          'Yes'
                                        end
                                      # If a source_url exists check if
                                      # that line has 'version' in it.
                                      elsif !@pkg.source_url.nil?
                                        if `grep source_url #{filename} | grep '\#{version'`.empty?
                                          'static source_url'
                                        else
                                          'Yes'
                                        end
                                      # Assume true otherwise.
                                      # rubocop:disable Lint/DuplicateBranch
                                      else
                                        'Yes'
                                      end
    # rubocop:enable Lint/DuplicateBranch
    @pkg_names[@pkg.name.to_sym] = @pkg.name
    version_line_string[@pkg.name.to_sym] = ''

    # We aren't interested in trying to find the upstream versions of fake packages.
    # We also aren't interested in finding upstream verisons for packages that are guaranteed not to have them.
    if @pkg.is_fake? || NO_UPSTREAM_VERSION_PKGS.include?(@pkg.name) || @pkg.no_upstream_update?
      upstream_version = ''
    elsif %w[RUBY].include?(@pkg.superclass.to_s)
      gem_name = @pkg.name.sub('ruby_', '')
      # We replace all dashes with underscores in our initial package names, but some gems actually use underscores, so we need special cases.
      # This list was created by looking at what packages were listed as not having updates in rubygems, and then looking up the upstream name for them.
      if %w[
        connection_pool error_highlight jaro_winkler
        lint_roller method_source mini_mime multi_xml mutex_m
        power_assert regexp_parser repl_type_completor ruby2_keywords
        syntax_suggest
      ].include?(gem_name)
        # These gems used underscores originally, so don't replace anything
      elsif gem_name == 'language_server_protocol'
        # These gems have an underscore then a dash, but there's only one, so we hardcode the logic for now.
        gem_name = 'language_server-protocol'
      elsif gem_name == 'unicode_display_width'
        # These gems have a dash then an underscore, but there's only one, so we hardcode the logic for now.
        gem_name = 'unicode-display_width'
      else
        # In the common case, the gem name used only dashes, which we all replaced with underscores.
        gem_name.gsub!('_', '-')
      end
      upstream_version = JSON.parse(Net::HTTP.get(URI("https://rubygems.org/api/v1/versions/#{gem_name}/latest.json")))['version']
    elsif %w[Pip].include?(@pkg.superclass.to_s)
      versions_updated[@pkg.name.to_sym] = 'Not Found.' if CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name)
      pip_name = @pkg.name.sub(/\Apy\d_/, '').gsub('_', '-')
      begin
        upstream_version = `pip index versions #{'--pre' if @pkg.prerelease?} #{pip_name} 2>/dev/null`.match(/#{Regexp.escape(pip_name)} \(([^)]+)\)/)[1]
      rescue NoMethodError
        versions_updated[@pkg.name.to_sym] = 'Not Found.'
      end
    else
      # Get the upstream version.
      upstream_version = get_version(@pkg.name, @pkg.homepage, PackageUtils.get_url(@pkg, build_from_source: true))
    end
    # If upstream_version is nil, convert it to an empty string so we don't have to worry about nil errors.
    upstream_version = upstream_version.to_s

    # If the upstream version is empty, this is either a fake package or we weren't able to find an upstream version.
    if upstream_version.empty?
      versions_updated[@pkg.name.to_sym] = if @pkg.is_fake?
                                             'Fake.'
                                           elsif NO_UPSTREAM_VERSION_PKGS.include?(@pkg.name) || @pkg.no_upstream_update?
                                             'Invalid.'
                                           else
                                             'Not Found.'
                                           end
    end

    unless upstream_version.empty?
      if VERY_VERBOSE
        crewlog "PackageUtils.get_clean_version(@pkg.version): #{PackageUtils.get_clean_version(@pkg.version)}"
        crewlog "upstream_version: #{upstream_version}"
        crewlog "Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version): #{Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version)}"
        crewlog "Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0: #{Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0}"
      end
      versions_updated[@pkg.name.to_sym] = 'Up to date.' if Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0
      if Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) == -1
        if UPDATE_PACKAGE_FILES && !CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name) && updatable_pkg[@pkg.name.to_sym] == 'Yes'
          file = File.read(filename)
          FileUtils.cp filename, "#{filename}.bak"
          if file.sub!(PackageUtils.get_clean_version(@pkg.version), upstream_version).nil?
            versions_updated[@pkg.name.to_sym] = false
          else
            # Version update succeeded. Now check for a sha256 update.
            old_hash = {}
            new_hash = {}
            # Handle source_url whether hash or not.
            if !@pkg.source_sha256.nil? && @pkg.source_sha256.is_a?(Hash) && @pkg.source_sha256&.key?(ARCH.to_sym)
              # Get old hashes
              (@pkg.source_url.keys.map &:to_s).each do |arch|
                puts "old source_url: #{@pkg.source_url[arch.to_sym]}" if VERBOSE && !OUTPUT_JSON
                old_hash[arch] = @pkg.source_sha256[arch.to_sym]
                puts "old hash: #{old_hash[arch]}" if VERBOSE && !OUTPUT_JSON
              end
              File.write(filename, file)
              # Now get new hashes
              @pkg = Package.load_package(filename, true)
              (@pkg.source_url.keys.map &:to_s).each do |arch|
                puts "new source_url: #{@pkg.source_url[arch.to_sym]}" if VERBOSE && !OUTPUT_JSON
                status = `curl -fsI #{@pkg.source_url[arch.to_sym]}`.lines.first.split[1]
                puts "new source_url response status: #{status}" if VERBOSE && !OUTPUT_JSON
                unless %w[200 302].include?(status)
                  versions_updated[@pkg.name.to_sym] = 'Bad Source'
                  puts "#{@pkg.source_url[arch.to_sym]} is a bad source".lightred if VERBOSE && !OUTPUT_JSON
                  if File.file?("#{filename}.bak")
                    FileUtils.cp "#{filename}.bak", filename
                    FileUtils.rm "#{filename}.bak"
                  end
                  next filename
                end
                new_hash[arch] = `curl -Ls #{@pkg.source_url[arch.to_sym]} | sha256sum - | awk '{print $1}'`.chomp
                puts "new hash: #{new_hash[arch]}" if VERBOSE && !OUTPUT_JSON
                file.sub!(old_hash[arch], new_hash[arch])
              end
            elsif !@pkg.source_sha256.nil? && !@pkg.source_sha256.is_a?(Hash)
              arch = :all
              # Get old hashes
              old_hash[arch] = @pkg.source_sha256
              puts "old source_url: #{@pkg.source_url}" if VERBOSE && !OUTPUT_JSON
              puts "old hash: #{old_hash[arch]}" if VERBOSE && !OUTPUT_JSON
              File.write(filename, file)
              # Now get new hashes
              @pkg = Package.load_package(filename, true)
              puts "new source_url: #{@pkg.source_url}" if VERBOSE && !OUTPUT_JSON
              status = `curl -fsI #{@pkg.source_url}`.lines.first.split[1]
              unless %w[200 302].include?(status)
                versions_updated[@pkg.name.to_sym] = 'Bad Source'
                puts "#{@pkg.source_url} is a bad source.".lightred if VERBOSE && !OUTPUT_JSON
                if File.file?("#{filename}.bak")
                  FileUtils.cp "#{filename}.bak", filename
                  FileUtils.rm "#{filename}.bak"
                end
                next filename
              end
              new_hash[arch] = `curl -Ls #{@pkg.source_url} | sha256sum - | awk '{print $1}'`.chomp
              puts "new hash: #{new_hash[arch]}" if VERBOSE && !OUTPUT_JSON
              file.sub!(old_hash[arch], new_hash[arch])
            end
            File.write(filename, file)
            puts "Successfully updated #{filename} to version #{upstream_version}.".lightgreen
            local_repo_root = ''
            Dir.chdir(ENV.fetch('PWD', nil)) do
              local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
            end
            if local_repo_root && File.file?("#{local_repo_root}/packages/#{@pkg.name}.rb") && (filename != "#{local_repo_root}/packages/#{@pkg.name}.rb")
              FileUtils.cp filename, "#{local_repo_root}/packages/#{@pkg.name}.rb"
              puts "Successfully updated #{local_repo_root}/packages/#{@pkg.name}.rb to version #{upstream_version}.".lightgreen
            end
            versions_updated[@pkg.name.to_sym] = true
            FileUtils.rm "#{filename}.bak" if File.file?("#{filename}.bak")
          end

          if @pkg.binary_compression == 'tar.xz' && !@pkg.no_zstd?
            file = File.read(filename)
            if file.sub!("binary_compression 'tar.xz'", "binary_compression 'tar.zst'").nil?
              bc_updated[@pkg.name.to_sym] = false
            else
              File.write(filename, file)
              bc_updated[@pkg.name.to_sym] = true
            end
          end
        end
        versions_updated[@pkg.name.to_sym] = if UPDATE_PACKAGE_FILES && !CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name) && versions_updated[@pkg.name.to_sym]
                                               'Updated.'
                                             else
                                               CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name) ? 'Update manually.' : 'Outdated.'
                                             end
      end
    end
    version_status_string = ''.ljust(status_field_length)
    updatable_string = nil
    case versions_updated[@pkg.name.to_sym]
    when 'Fake.'
      version_status_string = 'Fake.'.ljust(status_field_length).lightred
    when 'Invalid.'
      version_status_string = 'Invalid.'.ljust(status_field_length).lightred
    when 'Not Found.'
      version_status_string = 'Not Found.'.ljust(status_field_length).lightred
    when 'Outdated.'
      version_status_string = 'Outdated.'.ljust(status_field_length).yellow
    when 'Update manually.'
      version_status_string = 'Update manually.'.ljust(status_field_length).purple
      updatable_string = 'No'.ljust(version_field_length).purple
      updatable_pkg[@pkg.name.to_sym] = CREW_UPDATER_EXCLUDED_PKGS[@pkg.name] if CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name)
    when 'Updated.'
      version_status_string = 'Updated.'.ljust(status_field_length).blue
    when 'Up to date.'
      version_status_string = 'Up to date.'.ljust(status_field_length).lightgreen
    end
    updatable_string = (updatable_pkg[@pkg.name.to_sym] == 'Yes' ? 'Yes'.ljust(version_field_length).lightgreen : 'No'.ljust(version_field_length).lightred) if updatable_string.nil?
    compile_string = @pkg.no_compile_needed? || @pkg.is_fake? ? 'No'.lightred : 'Yes'.lightgreen
    versions.push(package: @pkg.name, update_status: versions_updated[@pkg.name.to_sym], version: cleaned_pkg_version, upstream_version: upstream_version)

    addendum_string = "#{@pkg.name} cannot be automatically updated: ".red + "#{updatable_pkg[@pkg.name.to_sym]}\n".purple unless updatable_pkg[@pkg.name.to_sym] == 'Yes'
    version_line_string[@pkg.name.to_sym] = "#{@pkg.name.ljust(package_field_length)}#{version_status_string}#{cleaned_pkg_version.ljust(version_field_length)}#{upstream_version.ljust(version_field_length)}#{updatable_string}#{compile_string}\n"
    print version_line_string[@pkg.name.to_sym] if !OUTPUT_JSON && ((versions_updated[@pkg.name.to_sym] == 'Outdated.' && updatable_pkg[@pkg.name.to_sym] == 'Yes') || OUTPUT_ALL)
    print addendum_string unless addendum_string.blank? || OUTPUT_JSON || !VERBOSE

    print "Failed to update version in #{@pkg.name} to #{upstream_version}".yellow if !OUTPUT_JSON && (versions_updated[@pkg.name.to_sym].to_s == 'false')
    print "Failed to update binary_compression in #{@pkg.name}".yellow if !OUTPUT_JSON && (bc_updated[@pkg.name.to_sym].to_s == 'false')
  end
  puts versions.to_json if OUTPUT_JSON
end
