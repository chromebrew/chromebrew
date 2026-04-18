#!/usr/bin/env ruby
# version.rb version 3.35 (for Chromebrew)

OPTIONS = %w[-a --all -h --help -j --json -u --update-package-files -v --verbose -vv]

if ARGV.include?('-h') || ARGV.include?('--help')
  abort <<~EOM
    Usage: ./version.rb [<package>] #{OPTIONS.to_s.gsub('"', '')}
    Example: ./version.rb abcde -v
    The <package> can contain '*': ./version.rb "xorg_*"
    If <package> is omitted, all packages will be processed.
    Passing --all or -a will display output for all packages, not just updatable outdated ones.
    Passing --update-package-files or -u will try to update the package version.
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

UPDATE_PACKAGE_FILES = ARGV.include?('-u') || ARGV.include?('--update-package-files')
OUTPUT_ALL = ARGV.include?('-a') || ARGV.include?('--all')
bc_updated = {}
updatable_pkg = {}
version_line_string = {}
versions_updated = {}
versions = []

# Some packages do not have upstream versions, often because they are internal chromebrew packages or because upstream doesn't have a versioning scheme.
NO_UPSTREAM_VERSION_PKGS = %w[clear_cache gdk_base hello_world_chromebrew ld_default xdg_base recomod vdev mywanip clmystery crew_preload cros_resize kwiml libbacktrace libpstat fskit speakify]

# Some packges aren't eligible to be automatically updated despite having upstream versions.
CREW_UPDATER_EXCLUDED_PKGS = Set[
  { pkg_name: 'foxit_reader', comments: 'Linux version is no longer updated.' },
  { pkg_name: 'glibc', comments: 'Requires manual update.' },
  { pkg_name: 'gpm', comments: 'Upstream is defunct.' },
  { pkg_name: 'linuxheaders', comments: 'Requires manual update.' },
  { pkg_name: 'pkg_config', comments: 'Upstream is abandoned.' },
  { pkg_name: 'util_linux', comments: 'Needs to be built with CREW_KERNEL_VERSION=5.10. See https://github.com/util-linux/util-linux/issues/3763' }
].to_h { |h| [h[:pkg_name], h[:comments]] }

# Some packages have different names in anitya.
# TODO: As per the section in CONTRIBUTING.md, most of these can be replaced with Anitya-side package mappings.
CREW_ANITYA_PACKAGE_NAME_MAPPINGS = Set[
  { pkg_name: 'alsa_lib', anitya_pkg: 'alsa-lib', comments: 'PackageUtils.get_clean_name mistakenly removes the _lib from the name' },
  { pkg_name: 'asdf', anitya_pkg: 'asdf-vm', comments: 'Anitya has a pip package named asdf' },
  { pkg_name: 'cvs', anitya_pkg: 'cvs-stable', comments: 'Anitya has a pip package named cvs' },
  { pkg_name: 'gexiv2', anitya_pkg: 'gexiv2~14.x', comments: 'TODO: Why are we sticking to the 0.14.x release series?' },
  { pkg_name: 'gnome_docking_library', anitya_pkg: 'gdl', comments: 'Anitya has two gdl packages, so this mapping doesnt work' },
  { pkg_name: 'go_tools', anitya_pkg: 'golang-tools', comments: 'Anitya has a different package named go-tools' },
  { pkg_name: 'gtk3', anitya_pkg: 'gtk+3.0~stable', comments: 'Anitya has Hackage, Rubygems, and CPAN (Perl) packages named gtk3' },
  { pkg_name: 'gtk4', anitya_pkg: 'gtk', comments: 'Anitya has Rubygems and crate.io packages named gtk3' },
  { pkg_name: 'gtksharp2', anitya_pkg: 'gtk-sharp', comments: 'The upstream Anitya package is mapped to gtk-sharp3 in other distros, but it is using the outdated mono/gtk-sharp repository so it is only getting the 2.x versions. Not sure what to do here.' },
  { pkg_name: 'hunspell_en_us', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'hunspell_es_any', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'hunspell_es_us', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'hunspell_fr_fr', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'js91', anitya_pkg: 'spidermonkey~91', comments: '' },
  { pkg_name: 'js102', anitya_pkg: 'spidermonkey~102', comments: '' },
  { pkg_name: 'js115', anitya_pkg: 'spidermonkey~115', comments: '' },
  { pkg_name: 'js140', anitya_pkg: 'spidermonkey~140', comments: '' },
  { pkg_name: 'libappindicator_gtk3', anitya_pkg: 'libappindicator', comments: '' },
  { pkg_name: 'libcom_err', anitya_pkg: 'e2fsprogs', comments: '' },
  { pkg_name: 'libdbusmenu_gtk3', anitya_pkg: 'libdbusmenu', comments: '' },
  { pkg_name: 'libgedit_amtk', anitya_pkg: 'libgedit-amtk', comments: 'Prefer to GitHub' },
  { pkg_name: 'libgedit_gtksourceview', anitya_pkg: 'libgedit-gtksourceview', comments: 'Prefer to GitHub' },
  { pkg_name: 'libgconf', anitya_pkg: 'gconf', comments: '' },
  { pkg_name: 'libhubbub', anitya_pkg: 'hubbub', comments: '' },
  { pkg_name: 'libindicator_gtk3', anitya_pkg: 'libindicator', comments: '' },
  { pkg_name: 'libkmod', anitya_pkg: 'kmod', comments: '' },
  { pkg_name: 'libmediainfo', anitya_pkg: 'mediainfo', comments: '' },
  { pkg_name: 'libnghttp3', anitya_pkg: 'nghttp3', comments: '' },
  { pkg_name: 'libngtcp2', anitya_pkg: 'ngtcp2', comments: '' },
  { pkg_name: 'libpeas2', anitya_pkg: 'libpeas', comments: '' },
  { pkg_name: 'libpth', anitya_pkg: 'pth', comments: '' },
  { pkg_name: 'libsdl', anitya_pkg: 'sdl', comments: '' },
  { pkg_name: 'libsoup2', anitya_pkg: 'libsoup2~stable', comments: '' },
  { pkg_name: 'libstfl', anitya_pkg: 'stfl', comments: '' },
  { pkg_name: 'libtinfo', anitya_pkg: 'ncurses', comments: '' },
  { pkg_name: 'libunbound', anitya_pkg: 'unbound', comments: '' },
  { pkg_name: 'libx264', anitya_pkg: 'x264', comments: '' },
  { pkg_name: 'linux_pam', anitya_pkg: 'pam', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_build", anitya_pkg: 'llvm', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_dev", anitya_pkg: 'llvm', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_lib", anitya_pkg: 'llvm', comments: '' },
  { pkg_name: 'mediainfo_gui', anitya_pkg: 'mediainfo', comments: '' },
  { pkg_name: 'mold', anitya_pkg: 'mold', comments: 'Prefer to GitHub' },
  { pkg_name: 'ninja', anitya_pkg: 'ninja-build', comments: '' },
  { pkg_name: 'nnn', anitya_pkg: 'nnn', comments: 'Prefer to GitHub' },
  { pkg_name: 'openssl', anitya_pkg: 'openssl-3.5-LTS', comments: 'Prefer to GitHub' },
  { pkg_name: 'owl', anitya_pkg: 'Owl Lisp', comments: '' },
  { pkg_name: 'pcre2', anitya_pkg: 'pcre2', comments: 'Prefer to GitHub' },
  { pkg_name: 'pkg_7_zip', anitya_pkg: '7zip~stable', comments: 'Prefer to GitHub' },
  { pkg_name: 'procps', anitya_pkg: 'procps-ng', comments: '' },
  { pkg_name: 'pthread_stubs', anitya_pkg: 'libpthread-stubs', comments: '' },
  { pkg_name: 'py3_atspi', anitya_pkg: 'pyatspi', comments: '' },
  { pkg_name: 'python3', anitya_pkg: 'python314', comments: '' },
  { pkg_name: 'rdfind', anitya_pkg: 'rdfind', comments: 'Prefer to GitHub' },
  { pkg_name: 'rest', anitya_pkg: 'librest', comments: 'Anitya has a package called rest, but we want librest.' },
  { pkg_name: 'selenium_server_standalone', anitya_pkg: 'selenium', comments: '' },
  { pkg_name: 'signal_desktop', anitya_pkg: 'signal', comments: '' },
  { pkg_name: 'smbclient', anitya_pkg: 'samba', comments: '' },
  { pkg_name: 'snowflake', anitya_pkg: 'Muon', comments: 'Renamed to muon upstream' },
  { pkg_name: 'tcpwrappers', anitya_pkg: 'tcp_wrappers', comments: '' },
  { pkg_name: 'tepl_6', anitya_pkg: 'libgedit-tepl', comments: '' },
  { pkg_name: 'upx', anitya_pkg: 'upx', comments: 'Prefer to GitHub' },
  { pkg_name: 'vidstab', anitya_pkg: 'vid.stab', comments: 'Prefer to GitHub' },
  { pkg_name: 'vim_runtime', anitya_pkg: 'vim', comments: '' },
  { pkg_name: 'wallstreet', anitya_pkg: 'hollywood', comments: '' },
  { pkg_name: 'wayland_info', anitya_pkg: 'wayland-utils', comments: '' },
  { pkg_name: 'webkit2gtk_4_0', anitya_pkg: 'webkitgtk~stable', comments: '' },
  { pkg_name: 'webkit2gtk_4_1', anitya_pkg: 'webkitgtk~stable', comments: '' },
  { pkg_name: 'webkitgtk_6', anitya_pkg: 'webkitgtk~stable', comments: '' },
  { pkg_name: 'xauth', anitya_pkg: 'xorg-x11-xauth', comments: '' },
  { pkg_name: 'xercesc', anitya_pkg: 'xerces-c', comments: 'Prefer to GitHub' },
  { pkg_name: 'xorg_proto', anitya_pkg: 'xorgproto', comments: '' },
  { pkg_name: 'xxd_standalone', anitya_pkg: 'vim', comments: '' },
  { pkg_name: 'yad', anitya_pkg: 'yad', comments: 'Prefer to GitHub' },
  { pkg_name: 'zig13', anitya_pkg: 'zig', comments: '' },
  { pkg_name: 'zimg', anitya_pkg: 'zimg', comments: 'Prefer to GitHub' },
  { pkg_name: 'zoneinfo', anitya_pkg: 'tzdata', comments: '' }
].to_h { |h| [h[:pkg_name], h[:anitya_pkg]] }

def get_version(name, homepage, source)
  anitya_id = get_anitya_id(name, homepage, @pkg.superclass.to_s)
  # We return nil if anitya_id cannot be determined.
  puts "anitya_id: #{anitya_id}" if CREW_VERY_VERBOSE
  if !anitya_id.nil?
    # Get the latest stable version of the package from anitya.
    json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/versions/?project_id=#{anitya_id}")))
    puts json if CREW_VERY_VERBOSE
    return json['latest_version'] if json['stable_versions'][0].nil?
    return json['stable_versions'][0]
  elsif !source.nil? && !source.is_a?(Hash)
    # If anitya has failed, we have a variety of fallbacks as a last resort.
    source.sub!('www.', '')
    url = URI.parse(source)
    puts "source_url host is #{url.host}" if CREW_VERY_VERBOSE
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
  puts "GitHub repo is #{repo}" if CREW_VERY_VERBOSE

  releases_json = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{repo}/releases/latest")))
  tags_json = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{repo}/tags")))

  # We check for the prescence of a message here because this will also gracefully handle rate limiting.
  if releases_json.include?('message') && (tags_json.empty? || tags_json.include?('message'))
    puts 'GitHub repo not found or no release/tag available.' if CREW_VERBOSE
    return
  end

  github_ver = releases_json['tag_name'].nil? ? tags_json[0]['name'] : releases_json['tag_name']
  puts "github_ver = #{github_ver}" if CREW_VERY_VERBOSE
  # Strip off any leading non-numeric characters.
  return github_ver.sub(/.*?(?=[0-9].)/im, '')
end

def gitlab_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 3

  repo = "#{url_parts[1]}/#{url_parts[2].delete_suffix('.git')}"
  redirect = Net::HTTP.get_response(URI("https://#{url.host}/#{repo}/-/releases/permalink/latest"))['location']

  if redirect == "https://#{url.host}/users/sign_in"
    puts 'GitLab repo not found.' if CREW_VERBOSE
  elsif redirect.nil?
    puts 'No releases available on GitLab repo.' if CREW_VERBOSE
  else
    gitlab_ver = redirect.split('/').last
    puts "gitlab_ver = #{gitlab_ver}" if CREW_VERY_VERBOSE
    # Strip off any leading non-numeric characters.
    return gitlab_ver.sub(/.*?(?=[0-9].)/im, '')
  end
end

def sourceforge_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 3

  repo = url_parts[2]
  puts "Sourceforge repo is #{repo}" if CREW_VERBOSE

  response = Net::HTTP.get_response(URI("https://sourceforge.net/projects/#{repo}/best_release.json"))
  if response.code == '404'
    puts 'Sourceforge repo not found.' if CREW_VERBOSE
    return
  end

  json = JSON.parse(response.body)
  if json['release'].nil?
    puts 'No releases available on Sourceforge repo.' if CREW_VERBOSE
    return
  end

  # Remove any preceding path components and remove any extensions, with an additional pass to remove .tar in the case of .tar.gz
  best_release = File.basename(json['release']['filename'], '.*').delete_suffix('.tar')
  puts "best_release = #{best_release}" if CREW_VERY_VERBOSE
  # Strip off any leading non-numeric characters.
  return best_release.sub(/.*?(?=[0-9].)/im, '')
end

def pagure_fallback(url)
  url_parts = url.path.split('/')
  return if url_parts.count < 2

  repo = url_parts[1]
  puts "Pagure repo is #{repo}" if CREW_VERBOSE

  json = JSON.parse(Net::HTTP.get(URI("https://pagure.io/api/0/#{repo}/git/tags")))
  if !json['error'].nil?
    puts 'Pagure repo not found.' if CREW_VERBOSE
  elsif json['total_tags'].zero?
    puts 'No tags available on Pagure repo.' if CREW_VERBOSE
  else
    pagure_ver = json['tags'][0]
    puts "pagure_ver = #{pagure_ver}" if CREW_VERY_VERBOSE
    # Strip off any leading non-numeric characters.
    return pagure_ver.sub(/.*?(?=[0-9].)/im, '')
  end
end

# For more information about working with Anitya, see the relevant section in CONTRIBUTING.md
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
  puts "anitya_name: #{anitya_name} #{"(instead of #{original_name})" if anitya_name != original_name}" if CREW_VERY_VERBOSE

  # Find out how many packages Anitya has with the provided name.
  puts "url is https://release-monitoring.org/api/v2/projects/?name=#{CGI.escape(anitya_name)}" if CREW_VERY_VERBOSE
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/projects/?name=#{CGI.escape(anitya_name)}")))
  puts json if CREW_VERY_VERBOSE
  number_of_packages = json['total_items']

  puts "number_of_packages = #{number_of_packages}" if CREW_VERY_VERBOSE
  if number_of_packages == 1 # We assume we have the right package, take the ID and move on.
    return json['items'][0]['id']
  elsif number_of_packages.zero? # Anitya either doesn't have this package, or has it under a different name.
    # The most likely scenario is that the correct name is the current one with underscores converted to dashes.
    if anitya_name.include?('_')
      prospective_anitya_id = get_anitya_id(anitya_name.tr('_', '-'), homepage, buildsystem)
      # If that is the case, return the Anitya ID we found, and if not, proceed to the next approach.
      return prospective_anitya_id unless prospective_anitya_id.nil?
    end

    # If it has it under a different name, check if it has the name used by Chromebrew.
    json2 = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/packages/?name=#{name}")))
    return if json2['total_items'].zero?

    # This checks if the Anitya project has a Chromebrew distribution mapping for this package.
    # The process of creating such a mapping is outlined in CONTRIBUTING.md
    (0..(json2['total_items'] - 1)).each do |i|
      next unless json2['items'][i]['distribution'] == 'Chromebrew'
      return get_anitya_id(json2['items'][i]['project'], homepage, buildsystem) if json2['items'][i]['name'] == name
    end

    # We have an explicit return here so we don't end up returning 0..0 if that is the outcome of the loop above.
    return
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
        puts "package_homepage = #{package_homepage}" if CREW_VERY_VERBOSE
        anitya_homepage = candidate['homepage'].sub(%r{http(s)?://(www\.)?}, '').chomp('/')
        puts "anitya_homepage = #{anitya_homepage}" if CREW_VERY_VERBOSE

        return candidate['id'] if package_homepage == anitya_homepage
      end
      puts 'No Anitya packages found.' if CREW_VERY_VERBOSE

      # If we're still here, that means none of the candidates had the same homepage as their crew counterpart.
      # Not much we can do at this point to find the version, and its better to be cautious to avoid getting the wrong candidate.
      return
    end
  end
end

def update_package_file(filename, upstream_version)
  pkg = Package.load_package(filename)
  file = File.read(filename)

  # This doesn't handle the case where a package has a tpxz binary compression and is no_zstd and so we would want to change it to tar.xz, because we only have 61 packages with a tpxz binary compression and none of them are no_zstd.
  if (pkg.binary_compression == 'tar.xz' && !pkg.no_zstd?) || pkg.binary_compression == 'tpxz'
    if file.sub!(/binary_compression '.*'/, "binary_compression 'tar.zst'").nil?
      bc_updated = false
    else
      File.write(filename, file)
      bc_updated = true
    end
  end

  # Update the version in the loaded file, exiting early if it failed.
  return false, bc_updated if file.sub!(PackageUtils.get_clean_version(pkg.version), upstream_version).nil?

  # Version update succeeded. Now check for a sha256 update.
  unless pkg.source_sha256.nil?
    # Get old hashes
    old_source_url = pkg.source_url.is_a?(Hash) ? pkg.source_url.values : [pkg.source_url]
    old_source_sha256 = pkg.source_sha256.is_a?(Hash) ? pkg.source_sha256.values : [pkg.source_sha256]
    old_source_url.zip(old_source_sha256).each do |url, sha256|
      puts "old source_url: #{url}" if CREW_VERBOSE && !CREW_OUTPUT_JSON
      puts "old source_sha256: #{sha256}" if CREW_VERBOSE && !CREW_OUTPUT_JSON
    end

    # Now get new hashes
    # This essentially replicates Package.load_package, but this way we don't have to make an early write to the actual package file before we confirm all the modifications are correct.
    Package.class_eval(file)
    pkg = Package.const_get(File.basename(filename, '.rb').capitalize)

    new_source_url = pkg.source_url.is_a?(Hash) ? pkg.source_url.values : [pkg.source_url]
    new_source_url.zip(old_source_sha256).each do |url, old_sha256|
      puts "new source_url: #{url}" if CREW_VERBOSE && !CREW_OUTPUT_JSON
      # Download the URL, following redirects until we reach the final destination.
      response = Net::HTTP.get_response(URI.parse(url))
      loop do
        break unless response.is_a?(Net::HTTPRedirection)
        url = response['location']
        response = Net::HTTP.get_response(URI.parse(url))
      end
      puts "new source_url response status: #{response.code}" if CREW_VERBOSE && !CREW_OUTPUT_JSON
      unless response.code == '200'
        puts "#{url} is a bad source".lightred if CREW_VERBOSE && !CREW_OUTPUT_JSON
        return 'Bad Source', bc_updated
      end
      new_sha256 = Digest::SHA256.hexdigest(response.body)
      puts "new source_sha256: #{new_sha256}" if CREW_VERBOSE && !CREW_OUTPUT_JSON
      file.sub!(old_sha256, new_sha256)
    end
  end
  File.write(filename, file)
  puts "Successfully updated #{filename} to version #{upstream_version}.".lightgreen
  local_repo_root = ''
  Dir.chdir(ENV.fetch('PWD', nil)) do
    local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
  end
  if local_repo_root && File.file?("#{local_repo_root}/packages/#{pkg.name}.rb") && (Pathname.new(filename).realpath.to_s != "#{local_repo_root}/packages/#{pkg.name}.rb")
    FileUtils.cp filename, "#{local_repo_root}/packages/#{pkg.name}.rb"
    puts "Successfully updated #{local_repo_root}/packages/#{pkg.name}.rb to version #{upstream_version}.".lightgreen
  end

  return true, bc_updated
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

  puts "#{'Package'.ljust(package_field_length)}#{'Status'.ljust(status_field_length)}#{'Current'.ljust(version_field_length)}#{'Upstream'.ljust(version_field_length)}Updatable?  Compile?  Autoupdate?" unless CREW_OUTPUT_JSON
  puts "#{'-------'.ljust(package_field_length)}#{'------'.ljust(status_field_length)}#{'-------'.ljust(version_field_length)}#{'--------'.ljust(version_field_length)}----------  --------  -----------" unless CREW_OUTPUT_JSON
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
                                      elsif !@pkg.source_url.nil? && (@pkg.source_url.is_a?(Hash) || @pkg.source_url.include?('SKIP'))
                                        'Yes'
                                      # If there is a git_hashtag, we can
                                      # check to see if 'version' is on
                                      # that line. Also allow _obj.git_hashtag
                                      # as we're using that for llvm packages.
                                      elsif !@pkg.git_hashtag.blank?
                                        if `grep "^  git_hashtag" #{filename} | grep "version\\|_obj.git_hashtag"`.empty? && @pkg.name != 'rust'
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
    version_line_string[@pkg.name.to_sym] = ''

    # We aren't interested in trying to find the upstream versions of fake packages.
    # We also aren't interested in finding upstream verisons for packages that are guaranteed not to have them.
    if @pkg.is_fake? || NO_UPSTREAM_VERSION_PKGS.include?(@pkg.name) || @pkg.no_upstream_update? || @pkg.name.start_with?('musl_')
      upstream_version = ''
    elsif %w[RUBY].include?(@pkg.superclass.to_s)
      _gem_name, _ruby_gem_version, upstream_version, _gem_installed_version, _gem_latest_version_installed, _gem_deps = PackageUtils.get_gem_vars(@pkg.name, @pkg.version, @pkg.upstream_name)
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
                                           elsif NO_UPSTREAM_VERSION_PKGS.include?(@pkg.name) || @pkg.no_upstream_update? || @pkg.name.start_with?('musl_')
                                             'Invalid.'
                                           else
                                             'Not Found.'
                                           end
    end

    unless upstream_version.empty?
      if CREW_VERY_VERBOSE
        crewlog "PackageUtils.get_clean_version(@pkg.version): #{PackageUtils.get_clean_version(@pkg.version)}"
        crewlog "upstream_version: #{upstream_version}"
        crewlog "Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version): #{Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version)}"
        crewlog "Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0: #{Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0}"
      end
      versions_updated[@pkg.name.to_sym], bc_updated[@pkg.name.to_sym] = update_package_file(filename, upstream_version) if (Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) == -1) && UPDATE_PACKAGE_FILES && !CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name) && updatable_pkg[@pkg.name.to_sym] == 'Yes'
      versions_updated[@pkg.name.to_sym] = if UPDATE_PACKAGE_FILES && !CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name) && versions_updated[@pkg.name.to_sym]
                                             'Updated.'
                                           else
                                             CREW_UPDATER_EXCLUDED_PKGS.key?(@pkg.name) ? 'Update manually.' : 'Outdated.'
                                           end
      versions_updated[@pkg.name.to_sym] = 'Up to date.' if Libversion.version_compare2(PackageUtils.get_clean_version(@pkg.version), upstream_version) >= 0
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
    updatable_string = (updatable_pkg[@pkg.name.to_sym] == 'Yes' ? 'Yes         '.lightgreen : 'No          '.lightred) if updatable_string.nil?
    compile_string = @pkg.no_compile_needed? || @pkg.is_fake? ? 'No        '.lightred : 'Yes       '.lightgreen
    autoupdate_string = File.file?("#{CREW_LIB_PATH}/tools/automatically_updatable_packages/#{@pkg.name}") && !File.file?("#{CREW_LIB_PATH}/tools/disabled_autobuild_packages/#{@pkg.name}") ? 'Yes'.lightgreen : 'No'.lightred
    versions.push(package: @pkg.name, updatable: updatable_pkg[@pkg.name.to_sym], update_status: versions_updated[@pkg.name.to_sym], version: cleaned_pkg_version, upstream_version: upstream_version)

    addendum_string = "#{@pkg.name} cannot be automatically updated: ".red + "#{updatable_pkg[@pkg.name.to_sym]}\n".purple unless updatable_pkg[@pkg.name.to_sym] == 'Yes'
    version_line_string[@pkg.name.to_sym] = "#{@pkg.name.ljust(package_field_length)}#{version_status_string}#{cleaned_pkg_version.ljust(version_field_length)}#{upstream_version.ljust(version_field_length)}#{updatable_string}#{compile_string}#{autoupdate_string}\n"
    print version_line_string[@pkg.name.to_sym] if !CREW_OUTPUT_JSON && ((versions_updated[@pkg.name.to_sym] == 'Outdated.' && updatable_pkg[@pkg.name.to_sym] == 'Yes') || OUTPUT_ALL)
    print addendum_string unless addendum_string.blank? || CREW_OUTPUT_JSON || !CREW_VERBOSE

    print "Failed to update version in #{@pkg.name} to #{upstream_version}".yellow if !CREW_OUTPUT_JSON && ['false', 'Bad Source'].include?(versions_updated[@pkg.name.to_sym].to_s)
    print "Failed to update binary_compression in #{@pkg.name}".yellow if !CREW_OUTPUT_JSON && (bc_updated[@pkg.name.to_sym].to_s == 'false')
  end
  puts versions.to_json if CREW_OUTPUT_JSON
end
