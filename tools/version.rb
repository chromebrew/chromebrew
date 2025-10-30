#!/usr/bin/env ruby
# version.rb version 3.11 (for Chromebrew)

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

OUTPUT_JSON = ARGV.include?('-j') || ARGV.include?('--json')
UPDATE_PACKAGE_FILES = ARGV.include?('-u') || ARGV.include?('--update-package-files')
VERBOSE = ARGV.include?('-v') || ARGV.include?('--verbose') || ARGV.include?('-vv')
VERY_VERBOSE = ARGV.include?('-vv')
bc_updated = {}
@pkg_names = {}
updatable_pkg = {}
version_line_string = {}
versions_updated = {}
versions = []

def get_version(name, homepage, source, version)
  anitya_name_mapping_idx = CREW_ANITYA_PACKAGE_NAME_MAPPINGS.keys.find_index { |i| i == name }
  anitya_name = name.gsub(/\Apy\d_|\Aperl_|\Aruby_/, '')
  anitya_name = CREW_ANITYA_PACKAGE_NAME_MAPPINGS.values[anitya_name_mapping_idx] unless anitya_name_mapping_idx.nil?
  anitya_id = get_anitya_id(anitya_name, homepage)
  anitya_name = @new_anitya_name unless @new_anitya_name.nil?
  # If anitya_id cannot be determined, a Range can be returned, and
  # .nonzero? does not work with Ranges.
  anitya_id = nil if anitya_id.is_a? Range
  puts "anitya_name: #{anitya_name} anitya_id: #{anitya_id}" if VERBOSE
  if anitya_id&.nonzero?
    # Get the latest stable version of the package from anitya.
    json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/versions/?project_id=#{anitya_id}")))
    puts json if VERY_VERBOSE
    return if json['stable_versions'].nil?
    return json['stable_versions'][0]
  elsif source.nil? || %w[Pip].include?(@pkg.superclass.to_s)
    return
  else
    # If anitya has failed, check if the source is a GitHub repository
    # as a fallback.
    # Note that we only check releases on GitHub since semantic
    # version ordering isn't easy to get from tags.
    # You can get the last numeric tag using:
    # git -c 'versionsort.suffix=-' \
    # ls-remote --exit-code --refs --sort='version:refname' --tags https://github.com/#{repo} '*.*.*' \
    # | tail --lines=1 \
    # | cut --delimiter='/' --fields=3
    # However, since that does miss text tags, better to just use
    # anitya first.
    if source.is_a?(Hash)
      source_arch = (@pkg.source_url.keys.map &:to_s).first
      source = @pkg.source_url[source_arch.to_sym]
    end
    source.sub!('www.', '')
    url = URI.parse(source)
    puts "source_url host is #{url.host}" if VERY_VERBOSE
    case url.host
    when 'github.com'
      url_parts = url.path.split('/')
      unless url_parts.count < 3
        repo = "#{url_parts[1]}/#{url_parts[2].gsub(/.git\z/, '')}"
        puts "GitHub repo is #{repo}" if VERBOSE
        if File.which('gh')
          # This allows us to only get non-pre-release versions from
          # GitHub if such releases exist.
          puts "gh release ls --exclude-pre-releases --exclude-drafts -L 1 -R #{repo} --json tagName -q '.[] | .tagName'" if VERY_VERBOSE
          github_ver = `gh release ls --exclude-pre-releases --exclude-drafts -L 1 -R #{repo} --json tagName -q '.[] | .tagName'`.chomp if system 'gh auth status >/dev/null', exception: false
        else
          puts "curl https://api.github.com/repos/#{repo}/releases/latest -Ls | jq .tag_name -r" if VERY_VERBOSE
          status = `curl -fsI https://api.github.com/repos/#{repo}/releases/latest`.lines.first.split[1]
          if status == '404'
            puts 'GitHub repo not found.' if VERBOSE
            return
          end
          github_ver = `curl https://api.github.com/repos/#{repo}/releases/latest -Ls | jq .tag_name -r`.chomp
          puts "curl https://api.github.com/repos/#{repo}/tags -Ls | jq '.[0].name' -r" if VERY_VERBOSE && (github_ver.blank? || github_ver == 'null')
          github_ver = `curl https://api.github.com/repos/#{repo}/tags -Ls | jq '.[0].name' -r`.chomp if github_ver.blank? || github_ver == 'null'
        end
        unless github_ver.blank? || github_ver == 'null'
          puts "github_ver = #{github_ver}" if VERY_VERBOSE
          # Strip off any leading non-numeric characters.
          upstream_version = github_ver.sub(/.*?(?=[0-9].)/im, '').chomp
          return upstream_version
        end
      end
    when 'gitlab.com'
      url_parts = url.path.split('/')
      unless url_parts.count < 3
        repo = "#{url_parts[1]}/#{url_parts[2].gsub(/.git\z/, '')}"
        puts "GitLab repo is #{repo}" if VERBOSE
        status = `curl -fsI https://#{url.host}/#{repo}/-/releases/permalink/latest`.lines.first.split[1]
        if status == '404'
          puts 'GitLab repo not found.' if VERBOSE
          return
        end
        puts "curl https://#{url.host}/#{repo}/-/releases/permalink/latest -Ls | jq .tag_name -r" if VERY_VERBOSE
        gitlab_ver = `curl https://#{url.host}/#{repo}/-/releases/permalink/latest -Ls | jq .tag_name -r`.chomp
        unless gitlab_ver.blank? || gitlab_ver == 'null'
          puts "gitlab_ver = #{gitlab_ver}" if VERY_VERBOSE
          # Strip off any leading non-numeric characters.
          upstream_version = gitlab_ver.sub(/.*?(?=[0-9].)/im, '').chomp
          return upstream_version
        end
      end
    when 'downloads.sourceforge.net'
      url_parts = url.path.split('/')
      unless url_parts.count < 3
        repo = url_parts[2]
        filename = url_parts.last
        puts "Sourceforge repo is #{repo}" if VERBOSE
        status = `curl -fsI https://sourceforge.net/projects/#{repo}/best_release.json`.lines.first.split[1]
        if status == '404'
          puts 'Sourceforge repo not found.' if VERBOSE
          return
        end
        puts "curl https://sourceforge.net/projects/#{repo}/best_release.json -Ls | jq .release.filename -r" if VERY_VERBOSE
        sourceforge_file = `curl https://sourceforge.net/projects/#{repo}/best_release.json -Ls | jq .release.filename -r`.chomp
        best_release = sourceforge_file.split('/').last
        if filename == best_release
          return version
        else
          puts "best_release = #{best_release}" if VERY_VERBOSE
          # Strip off any leading non-numeric characters.
          upstream_version = best_release.sub(/.*?(?=[0-9].)/im, '').chomp
          return upstream_version
        end
      end
    end
  end
end

def get_anitya_id(name, homepage)
  # Ignore python pip and ruby gem packages in the Pip and RUBY
  # superclasses.
  return if %w[Pip RUBY].include?(@pkg.superclass.to_s)

  # Find out how many packages Anitya has with the provided name.
  puts "url is https://release-monitoring.org/api/v2/projects/?name=#{CGI.escape(name)}" if VERY_VERBOSE
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/projects/?name=#{CGI.escape(name)}")))
  puts json if VERY_VERBOSE
  number_of_packages = json['total_items']

  puts "number_of_packages = #{number_of_packages}" if VERY_VERBOSE
  if number_of_packages == 1 # We assume we have the right package, take the ID and move on.
    return json['items'][0]['id']
  elsif number_of_packages.zero? # Anitya either doesn't have this package, or has it under a different name.
    @new_anitya_name = nil
    name_candidate = name.tr('-', '_') if name.include?('-')
    name_candidate = name.tr('_', '-') if name.include?('_')
    if name_candidate && name_candidate != name
      if VERY_VERBOSE
        puts "No Anitya package found with #{name}. Attempting a new search with #{name_candidate}."
        puts "url is https://release-monitoring.org/api/v2/projects/?name=#{name_candidate}"
      end
      json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/projects/?name=#{name_candidate}")))
      puts json if VERY_VERBOSE
      number_of_packages = json['total_items']
      if number_of_packages.zero?
        puts "No Anitya package found with #{name_candidate}." if VERY_VERBOSE
        return
      elsif number_of_packages == 1 # We assume we have the right package.
        package_homepage = homepage.gsub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "package_homepage = #{package_homepage}" if VERY_VERBOSE
        anitya_homepage = json['items'][0]['homepage'].gsub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "anitya_homepage = #{anitya_homepage}" if VERY_VERBOSE
        @new_anitya_name = json['items'][0]['name']
        return json['items'][0]['id']
      else
        (0..(number_of_packages - 1)).each do |i|
          next if json['items'][i].nil?
          package_homepage = homepage.gsub(%r{http(s)?://(www\.)?}, '').chomp('/')
          puts "package_homepage = #{package_homepage}" if VERY_VERBOSE
          anitya_homepage = json['items'][i]['homepage'].gsub(%r{http(s)?://(www\.)?}, '').chomp('/')
          puts "anitya_homepage = #{anitya_homepage}" if VERY_VERBOSE
          if package_homepage == anitya_homepage
            @new_anitya_name = name_candidate
            return json['items'][i]['id']
          end
        end
      end
    end
  else # Anitya has more than one package with this exact name.
    candidates = []
    # First, we remove any candidates which are provided by language package managers, such as pip.
    # This is because Chromebrew does not repackage them (#7713), so they won't be what we're looking for.
    # (Allow non Pip superclass Python packages through.)
    (0..(number_of_packages - 1)).each do |i|
      if %w[Python].include?(@pkg.superclass.to_s)
        candidates.append(i) if json['items'][i]['ecosystem'] == 'pypi'
      elsif %w[PERL].include?(@pkg.superclass.to_s)
        candidates.append(i) if json['items'][i]['backend'] == 'CPAN (perl)'
      elsif json['items'][i]['ecosystem'] == json['items'][i]['homepage']
        # If a package is not provided by a language package manager, the ecosystem will be set to the homepage.
        # https://release-monitoring.org/static/docs/api.html#get--api-v2-projects-
        candidates.append(i)
      end
    end
    puts "candidates = #{candidates}" if VERY_VERBOSE

    if candidates.length == 1 # If there's only one candidate left, we're done.
      return json['items'][candidates[0]]['id']
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
        package_homepage = homepage.gsub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "package_homepage = #{package_homepage}" if VERY_VERBOSE
        anitya_homepage = json['items'][candidate]['homepage'].gsub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "anitya_homepage = #{anitya_homepage}" if VERY_VERBOSE
        return json['items'][candidate]['id'] if package_homepage == anitya_homepage
      end
      puts 'No Anitya packages found.' if VERY_VERBOSE

      # If we're still here, that means none of the candidates had the same homepage as their crew counterpart.
      # Not much we can do at this point to find the version, and its better to be cautious to avoid getting the wrong candidate.
      return
    end
  end
end

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
    if @pkg.is_fake?
      # Just skip is_fake packages.
      versions_updated[@pkg.name.to_sym] = 'Fake'
      updatable_pkg[@pkg.name.to_sym] = 'No'
      next
    end
    # Mark package file as updatable (i.e., the version field can be
    # updated in the package file) if the string "version" is on the
    # git_hashtag line or the string "#{version}" is on the source_url
    # line.
    updatable_pkg[@pkg.name.to_sym] = if @pkg.ignore_updater?
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
    # We annotate some packages to let us know that they won't work here.
    versions_updated[@pkg.name.to_sym] = 'Up to date.' if @pkg.no_upstream_update?

    if %w[RUBY].include?(@pkg.superclass.to_s)
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
      versions_updated[@pkg.name.to_sym] = 'Not Found.' if @pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/]
      pip_name = @pkg.name.sub(/\Apy\d_/, '').gsub('_', '-')
      begin
        upstream_version = `pip index versions #{'--pre' if @pkg.prerelease?} #{pip_name} 2>/dev/null`.match(/#{Regexp.escape(pip_name)} \(([^)]+)\)/)[1]
      rescue NoMethodError
        versions_updated[@pkg.name.to_sym] = 'Not Found.'
      end
    else
      # Get the upstream version.
      upstream_version = get_version(@pkg.name, @pkg.homepage, @pkg.source_url, @pkg.version)
    end
    # Some packages don't work with this yet, so gracefully exit now rather than throwing false positives.
    versions_updated[@pkg.name.to_sym] = 'Not Found.' if upstream_version.nil? || upstream_version.to_s.chomp == 'null'

    unless upstream_version.nil?
      versions_updated[@pkg.name.to_sym] = 'Up to date.' if (Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0) && versions_updated[@pkg.name.to_sym] != 'Not Found.'
      if Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) == -1
        if UPDATE_PACKAGE_FILES && !@pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/] && updatable_pkg[@pkg.name.to_sym] == 'Yes'
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
        versions_updated[@pkg.name.to_sym] = if UPDATE_PACKAGE_FILES && !@pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/] && versions_updated[@pkg.name.to_sym]
                                               'Updated.'
                                             else
                                               @pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/] ? 'Update manually.' : 'Outdated.'
                                             end
      end
    end
    version_status_string = ''.ljust(status_field_length)
    updatable_string = nil
    case versions_updated[@pkg.name.to_sym]
    when 'Fake'
      version_status_string = 'Fake'.ljust(status_field_length).lightred
      upstream_version = ''
    when 'Not Found.'
      version_status_string = 'Not Found.'.ljust(status_field_length).lightred
      upstream_version = ''
    when 'Outdated.'
      version_status_string = 'Outdated.'.ljust(status_field_length).yellow
    when 'Update manually.'
      version_status_string = 'Update manually.'.ljust(status_field_length).purple
      updatable_string = 'No'.purple
      if @pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/]
        exclusion_mapping_idx = CREW_UPDATER_EXCLUDED_PKGS.keys.find_index { |i| i == @pkg.name }
        updatable_pkg[@pkg.name.to_sym] = exclusion_mapping_idx.nil? ? nil : CREW_UPDATER_EXCLUDED_PKGS.values[exclusion_mapping_idx]
      end
    when 'Updated.'
      version_status_string = 'Updated.'.ljust(status_field_length).blue
    when 'Up to date.'
      version_status_string = 'Up to date.'.ljust(status_field_length).lightgreen
    end
    updatable_string = (updatable_pkg[@pkg.name.to_sym] == 'Yes' ? 'Yes'.ljust(version_field_length).lightgreen : 'No'.ljust(version_field_length).lightred) if updatable_string.nil?
    compile_string = @pkg.no_compile_needed? ? 'No'.lightred : 'Yes'.lightgreen
    versions.push(package: @pkg.name, update_status: versions_updated[@pkg.name.to_sym], version: cleaned_pkg_version, upstream_version: upstream_version)

    addendum_string = "#{@pkg.name} cannot be automatically updated: ".red + "#{updatable_pkg[@pkg.name.to_sym]}\n".purple unless updatable_pkg[@pkg.name.to_sym] == 'Yes'
    version_line_string[@pkg.name.to_sym] = "#{@pkg.name.ljust(package_field_length)}#{version_status_string}#{cleaned_pkg_version.ljust(version_field_length)}#{upstream_version.ljust(version_field_length)}#{updatable_string}#{compile_string}\n"
    print version_line_string[@pkg.name.to_sym] if !OUTPUT_JSON && ((versions_updated[@pkg.name.to_sym] == 'Outdated.' && updatable_pkg[@pkg.name.to_sym] == 'Yes') || VERBOSE)
    print addendum_string unless addendum_string.blank? || OUTPUT_JSON || !VERBOSE

    print "Failed to update version in #{@pkg.name} to #{upstream_version}".yellow if !OUTPUT_JSON && (versions_updated[@pkg.name.to_sym].to_s == 'false')
    print "Failed to update binary_compression in #{@pkg.name}".yellow if !OUTPUT_JSON && (bc_updated[@pkg.name.to_sym].to_s == 'false')
  end
  puts versions.to_json if OUTPUT_JSON
end
