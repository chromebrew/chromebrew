#!/usr/bin/env ruby
# version.rb version 1.5 (for Chromebrew)

OPTIONS = %w[-h --help -j --json -u --update-package-files -v --verbose]

if ARGV.include?('-h') || ARGV.include?('--help')
  abort <<~EOM
    Usage: ./version.rb [<package>] #{OPTIONS.to_s.gsub('"', '')}
    Example: ./version.rb abcde -v
    The <package> can contain '*': ./version.rb "xorg_*"
    If <package> is omitted, all packages will be processed.
    Passing --update-package-files or -u will try to update the version
    field in the package file.
    Passing --json or -j will only give json output.
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
require File.join(crew_local_repo_root, 'lib/package')
require File.join(crew_local_repo_root, 'lib/package_utils')
require File.join(crew_local_repo_root, 'lib/require_gem')
require_gem 'ruby-libversion', 'ruby_libversion'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift File.join(crew_local_repo_root, 'lib')

OUTPUT_JSON = ARGV.include?('-j') || ARGV.include?('--json')
UPDATE_PACKAGE_FILES = ARGV.include?('-u') || ARGV.include?('--update-package-files')
VERBOSE = ARGV.include?('-v') || ARGV.include?('--verbose')
bc_updated = {}
pkg_names = {}
version_line_string = {}
versions_updated = {}
versions = []

def get_version(name, homepage, source)
  # Determine if the source is a GitHub repository.
  unless source.nil? || source.is_a?(Hash)
    source.sub!('www.', '')
    url = URI.parse(source)
    if url.host == 'github.com'
      url_parts = url.path.split('/')
      unless url_parts.count < 3
        repo = "#{url_parts[1]}/#{url_parts[2]}"
        return `curl https://api.github.com/repos/#{repo}/releases/latest -s | jq .name -r`
      end
    end
  end
  anitya_name_mapping_idx = CREW_ANITYA_PACKAGE_NAME_MAPPINGS.keys.find_index { |i| i == name }
  anitya_name = anitya_name_mapping_idx.nil? ? name : CREW_ANITYA_PACKAGE_NAME_MAPPINGS.values[anitya_name_mapping_idx]
  anitya_id = get_anitya_id(anitya_name, homepage)
  # If we weren't able to get an Anitya ID, return early here to save time and headaches
  return if anitya_id.nil?
  # Get the latest stable version of the package
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/versions/?project_id=#{anitya_id}")))
  return if json['stable_versions'].nil?
  return json['stable_versions'][0]
end

def get_anitya_id(name, homepage)
  # Ignore python and ruby packages.
  return if name.to_s.start_with?('py2_', 'py3_', 'ruby_')
  # Find out how many packages Anitya has with the provided name.
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/projects/?name=#{name}")))
  number_of_packages = json['total_items']

  if number_of_packages == 1 # We assume we have the right package, take the ID and move on.
    return json['items'][0]['id']
  elsif number_of_packages.zero? # Anitya either doesn't have this package, or has it under a different name.
    # If it has it under a different name, check if it has the name used by Chromebrew.
    json2 = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/packages/?name=#{name.tr('-', '_')}")))
    return if json2['total_items'].zero?

    (0..(json2['total_items'] - 1)).each do |i|
      next unless json2['items'][i]['distribution'] == 'Chromebrew'
      return get_anitya_id(json2['items'][i]['project'], homepage) if json2['items'][i]['name'] == name.tr('-', '_')
    end
  else # Anitya has more than one package with this exact name.
    candidates = []
    # First, we remove any candidates which are provided by language package managers, such as pip.
    # This is because Chromebrew does not repackage them (#7713), so they won't be what we're looking for.
    (0..(number_of_packages - 1)).each do |i|
      # If a package is not provided by a language package manager, the ecosystem will be set to the homepage.
      # https://release-monitoring.org/static/docs/api.html#get--api-v2-projects-
      candidates.append(i) if json['items'][i]['ecosystem'] == json['items'][i]['homepage']
    end

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
        return json['items'][candidate]['id'] if homepage == json['items'][candidate]['homepage']
      end

      # If we're still here, that means none of the candidates had the same homepage as their crew counterpart.
      # Not much we can do at this point to find the version, and its better to be cautious to avoid getting the wrong candidate.
      return
    end
  end
end

filelist = []
if ARGV.length.positive? && !(ARGV.length == 1 && OPTIONS.include?(ARGV[0]))
  ARGV.each do |arg|
    arg = arg.gsub('.rb', '')
    next unless arg =~ /^[0-9a-zA-Z\_\*]+$/
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

if filelist.length.positive?
  max_pkg_name_length = File.basename(filelist.max_by(&:length)).length - 3
  package_field_length = [max_pkg_name_length, 7].max + 4
  status_field_length = 20
  version_field_length = 16

  puts "#{'Package'.ljust(package_field_length)}#{'Status'.ljust(status_field_length)}#{'Current'.ljust(version_field_length)}Upstream" unless OUTPUT_JSON
  puts "#{'-------'.ljust(package_field_length)}#{'------'.ljust(status_field_length)}#{'-------'.ljust(version_field_length)}--------" unless OUTPUT_JSON
  filelist.each do |filename|
    pkg = Package.load_package(filename)
    pkg_names[pkg.name.to_sym] = pkg.name
    version_line_string[pkg.name.to_sym] = ''
    # We annotate some packages to let us know that they won't work here.
    versions_updated[pkg.name.to_sym] = 'Up to date.' if pkg.no_upstream_update?
    if pkg.is_fake?
      versions_updated[pkg.name.to_sym] = 'Fake'
      next
    end

    if %w[RUBY].include?(pkg.superclass.to_s)
      gem_name = pkg.name.sub('ruby_', '')
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
    elsif %w[Pip].include?(pkg.superclass.to_s)
      versions_updated[pkg.name.to_sym] = 'Not Found.' if pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/]
      pip_name = pkg.name.sub('py3_', '').gsub('_', '-')
      begin
        upstream_version = `pip index versions #{'--pre' if pkg.prerelease?} #{pip_name} 2>/dev/null`.match(/#{Regexp.escape(pip_name)} \(([^)]+)\)/)[1]
      rescue NoMethodError
        versions_updated[pkg.name.to_sym] = 'Not Found.'
      end
    else
      # Get the upstream version.
      upstream_version = get_version(pkg.name.tr('_', '-'), pkg.homepage, pkg.source_url)
    end
    # Some packages don't work with this yet, so gracefully exit now rather than throwing false positives.
    versions_updated[pkg.name.to_sym] = 'Not Found.' if upstream_version.nil? || upstream_version.to_s.chomp == 'null'

    unless upstream_version.nil?
      versions_updated[pkg.name.to_sym] = 'Up to date.' if (Libversion.version_compare2(PackageUtils.get_clean_version(pkg.version), upstream_version) >= 0) && versions_updated[pkg.name.to_sym] != 'Not Found.'
      if Libversion.version_compare2(PackageUtils.get_clean_version(pkg.version), upstream_version) == -1
        if UPDATE_PACKAGE_FILES && !pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/]
          # sed_cmd = <<~SED
          #   grep "^  version '#{PackageUtils.get_clean_version(pkg.version)}'" #{filename} && sed "s,^  version '#{PackageUtils.get_clean_version(pkg.version)}',  version '#{upstream_version.chomp}'," #{filename} > #{filename}.tmp && mv #{filename}.tmp #{filename}
          # SED
          # `#{sed_cmd}`
          
          file = File.read(filename)
          if file.sub!(PackageUtils.get_clean_version(pkg.version), upstream_version.chomp).nil?
            versions_updated[pkg.name.to_sym] = false
          else
            File.write(filename, file)
            versions_updated[pkg.name.to_sym] = true
          end
          # versions_updated[pkg.name.to_sym] = $CHILD_STATUS.success?

          binary_compression_sed_cmd = <<~BC_SED
            sed "s,^  binary_compression 'tar.xz',  binary_compression 'tar.zst'," #{filename} > #{filename}.tmp && mv #{filename}.tmp #{filename}
          BC_SED
          if pkg.binary_compression == 'tar.xz' && !pkg.no_zstd?
            `#{binary_compression_sed_cmd}`
            bc_updated[pkg.name.to_sym] = $CHILD_STATUS.success?
          end
        end
        if UPDATE_PACKAGE_FILES && !pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/] && versions_updated[pkg.name.to_sym]
          versions_updated[pkg.name.to_sym] = 'Updated.'
        else
          versions_updated[pkg.name.to_sym] = pkg.name[/#{CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX}/] ? 'Update manually.' : 'Outdated.'
          FileUtils.rm_f "#{filename}.tmp"
        end
      end
    end
    # puts PackageUtils.get_clean_version(pkg.version).ljust(status_field_length) + upstream_version unless OUTPUT_JSON
    version_status_string = ''.ljust(status_field_length)
    case versions_updated[pkg.name.to_sym]
    when 'Fake'
      version_status_string = 'Fake'.ljust(status_field_length).lightred
      upstream_version = ''
    when 'Not Found.'
      version_status_string = 'Not Found.'.ljust(status_field_length).lightred
      upstream_version = ''
    when 'Outdated.'
      version_status_string = 'Outdated.'.ljust(status_field_length).yellow
    when 'Update manually.'
      version_status_string = 'Update manually.'.ljust(status_field_length).red
    when 'Updated.'
      version_status_string = 'Updated.'.ljust(status_field_length).blue
    when 'Up to date.'
      version_status_string = 'Up to date.'.ljust(status_field_length).lightgreen
    end
    cleaned_pkg_version = PackageUtils.get_clean_version(pkg.version)
    versions.push(package: pkg.name, update_status: versions_updated[pkg.name.to_sym], version: cleaned_pkg_version, upstream_version: upstream_version.chomp)

    version_line_string[pkg.name.to_sym] = "#{pkg.name.ljust(package_field_length)}#{version_status_string}#{cleaned_pkg_version.ljust(version_field_length)}#{upstream_version}\n"
    print version_line_string[pkg.name.to_sym] unless OUTPUT_JSON

    print "failed sed cmd: #{sed_cmd}".ljust(sed_cmd.length).yellow if !OUTPUT_JSON && (versions_updated[pkg.name.to_sym].to_s == 'false')
    print "failed sed cmd: #{binary_compression_sed_cmd}".ljust(binary_compression_sed_cmd.length).yellow if !OUTPUT_JSON && (bc_updated[pkg.name.to_sym].to_s == 'false')
  end
  puts versions.to_json if OUTPUT_JSON
end
