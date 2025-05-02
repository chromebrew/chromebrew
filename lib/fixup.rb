# lib/fixup.rb
# Add fixups to be run during crew update here.
require 'etc'
require 'json'
require_relative 'color'
require_relative 'package'
require_relative 'require_gem'

require_gem('highline')

# All needed constants & variables should be defined here in case they
# have not yet been loaded or fixup is being run standalone.

CREW_VERBOSE ||= ARGV.intersect?(%w[-v --verbose]) unless defined?(CREW_VERBOSE)

CREW_PREFIX ||= '/usr/local'
CREW_LIB_PATH ||= File.join(CREW_PREFIX, 'lib/crew')

CREW_CONFIG_PATH ||= File.join(CREW_PREFIX, 'etc/crew')
CREW_META_PATH ||= File.join(CREW_CONFIG_PATH, 'meta')
CREW_REPO   ||= 'https://github.com/chromebrew/chromebrew.git'
CREW_BRANCH ||= 'master'

load "#{CREW_LIB_PATH}/lib/const.rb"
load "#{CREW_LIB_PATH}/lib/package.rb"
load "#{CREW_LIB_PATH}/lib/convenience_functions.rb"

KERN_ARCH ||= Etc.uname[:machine]
ARCH ||= %w[aarch64 armv8l].include?(KERN_ARCH) ? 'armv7l' : KERN_ARCH
LIBC_VERSION ||= Etc.confstr(Etc::CS_GNU_LIBC_VERSION).split.last
CREW_PACKAGES_PATH ||= File.join(CREW_LIB_PATH, 'packages')

# Removing files/directories.

# Remove deprecated directory.
FileUtils.rm_rf "#{HOME}/.cache/crewcache/manifest"

# Remove pagerenv tmp file in CREW_PACKAGES_PATH if it exists.
FileUtils.rm "#{CREW_PACKAGES_PATH}/pagerenv" if File.file?("#{CREW_PACKAGES_PATH}/pagerenv")
# Remove install.sh provided path file since we supersede it.

if File.exist?("#{CREW_PREFIX}/etc/env.d/00-path") && File.exist?("#{CREW_PREFIX}/etc/env.d/path")
  puts "Removing #{CREW_PREFIX}/etc/env.d/path installed by the Chromebrew installer.\n".orange
  FileUtils.rm "#{CREW_PREFIX}/etc/env.d/path"
end

# Updating git configuration.

Dir.chdir CREW_LIB_PATH do
  # Set new sparse-checkout paths for commands directory.
  system 'git sparse-checkout add commands'
  system 'git sparse-checkout reapply'

  # Set git timeout values for situations where GitHub is down.
  system 'git config --local http.lowSpeedLimit 1000' if `git config --local http.lowSpeedLimit`.empty?
  system 'git config --local http.lowSpeedTime 5' if `git config --local http.lowSpeedTime`.empty?
end

@fixup_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
def keep_keys(arr, keeper_keys)
  keepers = keeper_keys.to_set
  arr.map { |h| h.slice(*keepers) }
end
# Use @installed_packages.include?(pkg_name) to determine if a package is
# installed.
@installed_packages = keep_keys(@fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set

def save_json(json_object)
  crewlog 'Saving device.json...'
  begin
    File.write File.join(CREW_CONFIG_PATH, 'device.json.tmp'), JSON.pretty_generate(JSON.parse(json_object.to_json))
  rescue StandardError
    puts 'Error writing updated packages json file!'.lightred
    abort
  end
  # Copy over original if the write to the tmp file succeeds.
  FileUtils.cp("#{CREW_CONFIG_PATH}/device.json.tmp", File.join(CREW_CONFIG_PATH, 'device.json')) && FileUtils.rm("#{CREW_CONFIG_PATH}/device.json.tmp")
end

def refresh_crew_json
  if defined?(@device)
    @device = if @device['architecture'].nil?
                JSON.parse(@fixup_json.to_json, symbolize_names: true).transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
              else
                JSON.parse(@fixup_json.to_json)
              end
  end
end

# Rename the binary_sha256 variable to sha256 in the device.json file
system(" sed -i 's/binary_sha256/sha256/g' #{File.join(CREW_CONFIG_PATH, 'device.json')}")

# Check for renamed and deprecated packages, and handle them.

renamed_packages = Set[
  { pkg_name: 'acli', pkg_rename: 'acquia_cli', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'agrind', pkg_rename: 'angle_grinder', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'apriconv', pkg_rename: 'apr_iconv', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aprutil', pkg_rename: 'apr_util', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'arpscan', pkg_rename: 'arp_scan', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'asciidoc', pkg_rename: 'py3_asciidoc', comments: 'Renamed as a pip package.' },
  { pkg_name: 'aws', pkg_rename: 'aws_cli', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aws_cli', pkg_rename: 'awscli', comments: 'Renamed to match pip package name.' },
  { pkg_name: 'btrfsprogs', pkg_rename: 'btrfs_progs', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz2', pkg_rename: 'bzip2', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz3', pkg_rename: 'bzip3', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'chrome', pkg_rename: 'google_chrome', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'codium', pkg_rename: 'vscodium', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'dstat', pkg_rename: 'py3_dool', comments: 'Following upstream rename.' },
  { pkg_name: 'ffcall', pkg_rename: 'libffcall', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'itstool', pkg_rename: 'py3_itstool', comments: 'Renamed to indicate switch to pip buildsystem.' },
  { pkg_name: 'jsonc', pkg_rename: 'json_c', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libcurl', pkg_rename: 'curl', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libgpgerror', pkg_rename: 'libgpg_error', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libjpeg', pkg_rename: 'libjpeg_turbo', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'mandb', pkg_rename: 'man_db', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'mercurial', pkg_rename: 'py3_mercurial', comments: 'Renamed to match other pip packages.' },
  { pkg_name: 'meson', pkg_rename: 'py3_meson', comments: 'Renamed to avoid conflict with buildsystems/meson.' },
  { pkg_name: 'mesonbuild', pkg_rename: 'py3_meson', comments: 'Renamed to indicate switch to pip buildsystem.' },
  { pkg_name: 'moonbuggy', pkg_rename: 'moon_buggy', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'oci_cli', pkg_rename: 'py3_oci_cli', comments: 'Fix to match upstream name.' },
  { pkg_name: 'onepassword', pkg_rename: 'onepassword_cli', comments: 'Rename to distinguish between onepassword_gui.' },
  { pkg_name: 'percona_toolkit', pkg_rename: 'perl_percona_toolkit', comments: 'Renamed to identify perl package.' },
  { pkg_name: 'pkgconfig', pkg_rename: 'pkg_config', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'postgres', pkg_rename: 'postgresql', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'proj4', pkg_rename: 'proj', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'py3_appdirs', pkg_rename: 'py3_platformdirs', comments: 'Replaced upstream.' },
  { pkg_name: 'py3_agate_dfb', pkg_rename: 'py3_agate_dbf', comments: 'Fix to match upstream name.' },
  { pkg_name: 'py3_dateutil', pkg_rename: 'py3_python_dateutil', comments: 'Fix to match upstream name.' },
  { pkg_name: 'py3_magic', pkg_rename: 'py3_python_magic', comments: 'Fix to match upstream name.' },
  { pkg_name: 'py3_pptx', pkg_rename: 'py3_python_pptx', comments: 'Fix to match upstream name.' },
  { pkg_name: 'pygobject', pkg_rename: 'py3_pygobject', comments: 'Renamed to use pip packaging.' },
  { pkg_name: 'qtbase', pkg_rename: 'qt5_base', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtcharts', pkg_rename: 'qt5_charts', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtdeclarative', pkg_rename: 'qt5_declarative', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtimageformats', pkg_rename: 'qt5_imageformats', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtlocation', pkg_rename: 'qt5_location', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtmultimedia', pkg_rename: 'qt5_multimedia', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtquickcontrols', pkg_rename: 'qt5_quickcontrols', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtscript', pkg_rename: 'qt5_script', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtserialport', pkg_rename: 'qt5_serialport', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtsvg', pkg_rename: 'qt5_svg', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qttools', pkg_rename: 'qt5_tools', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtwayland', pkg_rename: 'qt5_wayland', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtwebchannel', pkg_rename: 'qt5_webchannel', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtwebengine', pkg_rename: 'qt5_webengine', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtwebglplugin', pkg_rename: 'qt5_webglplugin', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtwebsockets', pkg_rename: 'qt5_websockets', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'qtx11extras', pkg_rename: 'qt5_x11extras', comments: 'Renamed to allow qt6 packages.' },
  { pkg_name: 'ranger', pkg_rename: 'ranger_fm', comments: 'Renamed to match pip package name.' },
  { pkg_name: 'tracker3', pkg_rename: 'tinysparql', comments: 'Renamed upstream.' },
  { pkg_name: 'tracker3_miners', pkg_rename: 'localsearch', comments: 'Renamed upstream.' },
  { pkg_name: 'util_macros', pkg_rename: 'xorg_macros', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'wget', pkg_rename: 'wget2', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'zlibpkg', pkg_rename: 'zlib', comments: 'Renamed to better match upstream.' }
]

deprecated_packages = Set[
  { pkg_name: 'epydoc', comments: 'Abandoned upstream, only supports Python 2.' },
  { pkg_name: 'git_prompt', comments: 'Integrated into git package.' },
  { pkg_name: 'gnome_session', comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_settings_daemon', comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_shell', comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_tweaks', comments: 'No longer compatible with any architecture, requires systemd in dep package gnome_settings_daemon.' },
  { pkg_name: 'ilmbase', comments: 'Included in openexr.' },
  { pkg_name: 'imagemagick6', comments: 'Obsolete version of package, no longer required.' },
  { pkg_name: 'imagemagick', comments: 'Metapackage made redundant by the removal of imagemagick6.' },
  { pkg_name: 'js91', comments: 'Replaced by newer versions of js.' },
  { pkg_name: 'komodo', comments: 'Abandoned upstream and no longer functional.' },
  { pkg_name: 'libaudiofile', comments: 'Inactive upstream with applicable CVEs' },
  { pkg_name: 'libmfx', comments: 'No longer compatible with any architecture' },
  { pkg_name: 'linter', comments: 'Replaced with py3_pre_commit.' },
  { pkg_name: 'nping', comments: 'Removed to avoid conflict with nmap.' },
  { pkg_name: 'percona_boost', comments: 'Replaced by regular boost.' },
  { pkg_name: 'percona_server', comments: 'Replaced by mysql.' },
  { pkg_name: 'q', comments: 'No longer suitable for packaging.' },
  { pkg_name: 'qtchooser', comments: "Doesn't work for newer Qt versions." },
  { pkg_name: 'skype', comments: 'Officially sunsetting and will be shut down soon.' }
]

# Handle package renames.
renamed_pkgs = renamed_packages.map { |h| h[:pkg_name] }
installed_pkgs_to_rename = @installed_packages & renamed_pkgs

installed_pkgs_to_rename.each do |fixup_pkg|
  working_pkg = renamed_packages.find { |i| i[:pkg_name] == fixup_pkg }
  pkg_name = working_pkg[:pkg_name]
  pkg_rename = working_pkg[:pkg_rename]

  puts "#{pkg_name.capitalize} has been renamed to #{pkg_rename.capitalize}. #{working_pkg[:comments]}".lightpurple

  old_filelist = File.join(CREW_META_PATH, "#{pkg_name}.filelist")
  new_filelist = File.join(CREW_META_PATH, "#{pkg_rename}.filelist")
  old_directorylist = File.join(CREW_META_PATH, "#{pkg_name}.directorylist")
  new_directorylist = File.join(CREW_META_PATH, "#{pkg_rename}.directorylist")
  # Handle case of new package already installed.
  if @installed_packages.include?(pkg_rename)
    puts "Renamed #{pkg_rename.capitalize} is already installed. Deleting old package (#{pkg_rename.capitalize}) information...".lightblue
    FileUtils.rm_f [old_filelist, old_directorylist]
    @fixup_json['installed_packages'].delete_if { |elem| elem[:name] == pkg_name }
    @installed_packages = keep_keys(@fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set
    next
  end
  # Handle case of package needing to be replaced.
  if File.file?(new_filelist)
    puts "New filelist for #{pkg_rename.capitalize} already exists!"
    next
  end
  if File.file?(new_directorylist)
    puts "New directorylist for #{pkg_rename.capitalize} already exists!"
    next
  end
  # If new filelist or directorylist do not exist and new package is not
  # marked as installed in device.json then rename and edit json.
  FileUtils.mv old_filelist, new_filelist
  FileUtils.mv old_directorylist, new_directorylist
  @fixup_json['installed_packages'].find { |h| h['name'] == pkg_name }
  @fixup_json['installed_packages'].find { |h| h['name'] == pkg_name }['name'] = pkg_rename
end

unless installed_pkgs_to_rename.empty?
  @installed_packages = keep_keys(@fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set
  save_json(@fixup_json)
  refresh_crew_json
end

# Handle deprecated packages.
deprecated_pkgs = deprecated_packages.map { |h| h[:pkg_name] }
installed_pkgs_to_deprecate = @installed_packages & deprecated_pkgs

installed_pkgs_to_deprecate.each do |fixup_pkg|
  working_pkg = deprecated_packages.find { |i| i[:pkg_name] == fixup_pkg }
  pkg_name = working_pkg[:pkg_name]

  puts "#{pkg_name.capitalize} is deprecated and should be removed. #{working_pkg[:comments]}".lightpurple
  if Package.agree_default_yes("\nWould you like to remove deprecated package #{pkg_name.capitalize}")
    # Create a minimal Package object and pass it to Command.remove
    pkg_object = Package
    pkg_object.instance_eval do
      self.name = pkg_name
      def self.preremove; end
      def self.postremove; end
    end
    Command.remove(pkg_object, verbose: CREW_VERBOSE)
  else
    puts "#{pkg_name.capitalize} not removed.".lightblue
  end
end

# Reload json after all external fixups are done, as there may have been external changes.
unless installed_pkgs_to_deprecate.empty?
  @fixup_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
  @installed_packages = keep_keys(@fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set
  refresh_crew_json
end

# Handle broken system glibc affecting gcc_lib on newer x86_64 ChromeOS milestones.
if (ARCH == 'x86_64') && (Gem::Version.new(LIBC_VERSION.to_s) >= Gem::Version.new('2.36'))
  abort("patchelf is needed. Please run: 'crew update && crew install patchelf && crew update'") unless File.file?(File.join(CREW_PREFIX, 'bin/patchelf'))
  # Link the system libc.so.6 to also require our renamed libC.so.6
  # which provides the float128 functions strtof128, strfromf128,
  # and __strtof128_nan.
  # This creates tons of the following warnings when g++ is invoked with
  # g++ #{File.join(CREW_LIB_PREFIX, 'libC.so.6')}, but I'm not sure how
  # to get around that.
  # /usr/local/lib64/libC.so.6: linker input file unused because linking not done errors
  libc_patch_libraries = %w[libstdc++.so.6]
  libc_patch_libraries.delete_if { |lib| !File.file?(File.join(CREW_LIB_PREFIX, lib)) }
  libc_patch_libraries.delete_if { |lib| Kernel.system "patchelf --print-needed #{File.join(CREW_LIB_PREFIX, lib)} | grep -q libC.so.6" }

  return if libc_patch_libraries.empty?

  if File.file?(File.join(CREW_LIB_PREFIX, 'libC.so.6'))
    Dir.chdir(CREW_LIB_PREFIX) do
      libc_patch_libraries.each do |lib|
        Kernel.system "patchelf --add-needed libC.so.6 #{lib}" and Kernel.system "patchelf --remove-needed libc.so.6 #{lib}"
        puts "#{lib} patched for use with Chromebrew's glibc.".lightgreen
      end
    end
  end
end

# Reload @device with the appropriate symbolized or nonsymbolized json load before we exit fixup.
refresh_crew_json
