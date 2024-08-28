# lib/fixup.rb
# Add fixups to be run during crew update here.
require 'etc'
require 'json'
require_relative 'color'

def require_gem(gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if gem_name_and_require.nil?

  gem_name = gem_name_and_require.split('/')[0]
  begin
    gem gem_name
  rescue LoadError
    puts " -> install #{gem_name} gem".orange
    Gem.install(gem_name)
    gem gem_name
  end
  requires = if require_override.nil?
               gem_name_and_require.split('/')[1].nil? ? gem_name_and_require.split('/')[0] : gem_name_and_require
             else
               require_override
             end
  require requires
end
require_gem('highline')

# All needed constants & variables should be defined here in case they
# have not yet been loaded or fixup is being run standalone.

CREW_VERBOSE ||= ARGV.intersect?(%w[-v --verbose]) unless defined?(CREW_VERBOSE)

CREW_PREFIX ||= '/usr/local'
CREW_LIB_PATH ||= File.join(CREW_PREFIX, 'lib/crew')

load "#{CREW_LIB_PATH}/lib/const.rb"
load "#{CREW_LIB_PATH}/lib/package.rb"
load "#{CREW_LIB_PATH}/lib/convenience_functions.rb"

CREW_CONFIG_PATH ||= File.join(CREW_PREFIX, 'etc/crew')
CREW_META_PATH ||= File.join(CREW_CONFIG_PATH, 'meta')
# via git log --reverse --oneline lib/const.rb | head -n 1
CREW_CONST_GIT_COMMIT ||= '72d807aac'
CREW_REPO   ||= 'https://github.com/chromebrew/chromebrew.git'
CREW_BRANCH ||= 'master'

# Restart crew update as quickly as possibnle if the git commit of
# const.rb loaded in const.rb is different from the git commit of the
# potentially updated const.rb loaded here after a git pull.

unless `git -C #{CREW_LIB_PATH} log -n1 --oneline #{CREW_LIB_PATH}/lib/const.rb`.split.first == CREW_CONST_GIT_COMMIT
  puts 'Restarting crew update since there is an updated crew version.'.lightcyan
  puts "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update".orange if CREW_VERBOSE
  exec "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update"
end

KERN_ARCH ||= Etc.uname[:machine]
ARCH ||= %w[aarch64 armv8l].include?(KERN_ARCH) ? 'armv7l' : KERN_ARCH
LIBC_VERSION ||= Etc.confstr(Etc::CS_GNU_LIBC_VERSION).split.last
CREW_PACKAGES_PATH ||= File.join(CREW_LIB_PATH, 'packages')

fixup_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
def keep_keys(arr, keeper_keys)
  keepers = keeper_keys.to_set
  arr.map { |h| h.select { |k, _| keepers.include?(k) } }
end
# Use @installed_packages.include?(pkg_name) to determine if a package is
# installed.
@installed_packages = keep_keys(fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set

if fixup_json['essential_deps'].nil?
  puts 'Determining essential dependencies from CREW_ESSENTIAL_PACKAGES...'.orange if CREW_VERBOSE
  fixup_json['essential_deps'] = []
  fixup_json['essential_deps'].concat(CREW_ESSENTIAL_PACKAGES.flat_map { |i| Package.load_package("#{i}.rb").get_deps_list }.push(*CREW_ESSENTIAL_PACKAGES).uniq.sort)
  crewlog "Essential packages: #{fixup_json['essential_deps']}"
  ConvenienceFunctions.save_json(fixup_json)
  puts 'Determined compatibility & which packages are essential.'.orange if CREW_VERBOSE
end

# remove deprecated directory
FileUtils.rm_rf "#{HOME}/.cache/crewcache/manifest"

# Remove install.sh provided path file since we supersede it.
if File.exist?("#{CREW_PREFIX}/etc/env.d/00-path") && File.exist?("#{CREW_PREFIX}/etc/env.d/path")
  puts "Removing #{CREW_PREFIX}/etc/env.d/path installed by the Chromebrew installer.\n".orange
  FileUtils.rm "#{CREW_PREFIX}/etc/env.d/path"
end

Dir.chdir CREW_LIB_PATH do
  # Set new sparse-checkout paths for commands directory
  system 'git sparse-checkout add commands'
  system 'git sparse-checkout reapply'

  # Set git timeout values for situations where GitHub is down.
  system 'git config --local http.lowSpeedLimit 1000' if `git config --local http.lowSpeedLimit`.empty?
  system 'git config --local http.lowSpeedTime 5' if `git config --local http.lowSpeedTime`.empty?
end

# Rename the binary_sha256 variable to sha256 in the device.json file
system(" sed -i 's/binary_sha256/sha256/g' #{File.join(CREW_CONFIG_PATH, 'device.json')}")

# Check for renamed and deprecated packages, and handle them.

pkg_update_arr = [
  { pkg_name: 'acli', pkg_rename: 'acquia_cli', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'agrind', pkg_rename: 'angle_grinder', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'apriconv', pkg_rename: 'apr_iconv', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aprutil', pkg_rename: 'apr_util', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'arpscan', pkg_rename: 'arp_scan', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aws', pkg_rename: 'aws_cli', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aws_cli', pkg_rename: 'awscli', pkg_deprecated: nil, comments: 'Renamed to match pip package name.' },
  { pkg_name: 'btrfsprogs', pkg_rename: 'btrfs_progs', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz2', pkg_rename: 'bzip2', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz3', pkg_rename: 'bzip3', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'chrome', pkg_rename: 'google_chrome', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'codium', pkg_rename: 'vscodium', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'dstat', pkg_rename: 'py3_dool', pkg_deprecated: nil, comments: 'Following upstream rename.' },
  { pkg_name: 'epydoc', pkg_rename: nil, pkg_deprecated: true, comments: 'Abandoned upstream, only supports Python 2.' },
  { pkg_name: 'ffcall', pkg_rename: 'libffcall', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'git_prompt', pkg_rename: nil, pkg_deprecated: true, comments: 'Integrated into git package.' },
  { pkg_name: 'gnome_session', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_settings_daemon', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_shell', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_tweaks', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd in dep package gnome_settings_daemon.' },
  { pkg_name: 'ilmbase', pkg_rename: nil, pkg_deprecated: true, comments: 'Included in openexr.' },
  { pkg_name: 'imagemagick6', pkg_rename: nil, pkg_deprecated: true, comments: nil },
  { pkg_name: 'imagemagick', pkg_rename: nil, pkg_deprecated: true, comments: nil },
  { pkg_name: 'js91', pkg_rename: nil, pkg_deprecated: true, comments: 'Replaced by newer versions of js.' },
  { pkg_name: 'jsonc', pkg_rename: 'json_c', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libaudiofile', pkg_rename: nil, pkg_deprecated: true, comments: 'Inactive upstream with applicable CVEs' },
  { pkg_name: 'libcurl', pkg_rename: 'curl', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'libgpgerror', pkg_rename: 'libgpg_error', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libjpeg', pkg_rename: 'libjpeg_turbo', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libmfx', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture' },
  { pkg_name: 'linter', pkg_rename: nil, pkg_deprecated: true, comments: 'Replaced with py3_pre_commit.' },
  { pkg_name: 'mandb', pkg_rename: 'man_db', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'mercurial', pkg_rename: 'py3_mercurial', pkg_deprecated: nil, comments: 'Renamed to match other pip packages.' },
  { pkg_name: 'meson', pkg_rename: 'mesonbuild', pkg_deprecated: nil, comments: 'Renamed to avoid conflict with buildsystems/meson.' },
  { pkg_name: 'moonbuggy', pkg_rename: 'moon_buggy', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'nping', pkg_rename: nil, pkg_deprecated: true, comments: 'Removed to avoid conflict with nmap.' },
  { pkg_name: 'pkgconfig', pkg_rename: 'pkg_config', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'postgres', pkg_rename: 'postgresql', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'proj4', pkg_rename: 'proj', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'qtbase', pkg_rename: 'qt5_base', pkg_deprecated: nil, comments: 'Qt packages renamed to qt5_*' },
  { pkg_name: 'qtcharts', pkg_rename: 'qt5_charts', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtchooser', pkg_rename: nil, pkg_deprecated: true, comments: "Doesn't work for newer Qt versions." },
  { pkg_name: 'qtdeclarative', pkg_rename: 'qt5_declarative', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtimageformats', pkg_rename: 'qt5_imageformats', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtlocation', pkg_rename: 'qt5_location', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtmultimedia', pkg_rename: 'qt5_multimedia', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtquickcontrols', pkg_rename: 'qt5_quickcontrols', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtscript', pkg_rename: 'qt5_script', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtserialport', pkg_rename: 'qt5_serialport', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtsvg', pkg_rename: 'qt5_svg', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qttools', pkg_rename: 'qt5_tools', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtwayland', pkg_rename: 'qt5_wayland', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtwebchannel', pkg_rename: 'qt5_webchannel', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtwebengine', pkg_rename: 'qt5_webengine', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtwebglplugin', pkg_rename: 'qt5_webglplugin', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtwebsockets', pkg_rename: 'qt5_websockets', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'qtx11extras', pkg_rename: 'qt5_x11extras', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'ruby_debug', pkg_rename: nil, pkg_deprecated: true, comments: 'Integrated into ruby package.' },
  { pkg_name: 'tracker3', pkg_rename: 'tinysparql', pkg_deprecated: nil, comments: 'Renamed upstream.' },
  { pkg_name: 'tracker3_miners', pkg_rename: 'localsearch', pkg_deprecated: nil, comments: 'Renamed upstream.' },
  { pkg_name: 'util_macros', pkg_rename: 'xorg_macros', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'wget', pkg_rename: 'wget2', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'zlibpkg', pkg_rename: 'zlib', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' }
].to_set

fixup_pkgs = pkg_update_arr.to_set { |h| h[:pkg_name] }
installed_fixup_packages = @installed_packages & fixup_pkgs

# Handle package renames.
renamed_packages = false
installed_fixup_packages.each do |fixup_pkg|
  working_pkg = pkg_update_arr.select { |i| i[:pkg_name] == fixup_pkg }
  pkg_name = working_pkg[0][:pkg_name]
  pkg_rename = working_pkg[0][:pkg_rename]
  next unless pkg_rename

  renamed_packages = true
  comments = working_pkg[0][:comments]
  renamed_packages = true
  puts "#{pkg_name.capitalize} has been renamed to #{pkg_rename.capitalize}. #{comments.nil? ? '' : "(#{comments})"}".lightpurple

  old_filelist = File.join(CREW_META_PATH, "#{pkg_name}.filelist")
  new_filelist = File.join(CREW_META_PATH, "#{pkg_rename}.filelist")
  old_directorylist = File.join(CREW_META_PATH, "#{pkg_name}.directorylist")
  new_directorylist = File.join(CREW_META_PATH, "#{pkg_rename}.directorylist")
  # Handle case of new package already installed.
  if @installed_packages.include?(pkg_rename)
    puts "Renamed #{pkg_rename.capitalize} is already installed. Deleting old package (#{pkg_rename.capitalize}) information...".lightblue
    FileUtils.rm_f old_filelist
    FileUtils.rm_f old_directorylist
    fixup_json['installed_packages'].delete_if { |elem| elem[:name] == pkg_name }
    @installed_packages = keep_keys(fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set
    next
  end
  # Handle case of package needing to be replaced.
  if File.file?(new_filelist)
    puts "new filelist for #{pkg_rename.capitalize} already exists!"
    next
  end
  if File.file?(new_directorylist)
    puts "new directorylist for #{pkg_rename.capitalize} already exists!"
    next
  end
  # If new filelist or directorylist do not exist and new package is not
  # marked as installed in device.json then rename and edit device.json .
  FileUtils.mv old_filelist, new_filelist
  FileUtils.mv old_directorylist, new_directorylist
  fixup_json['installed_packages'].map do |x|
    x['name'] = pkg_rename if x['name'] == pkg_name
    puts "#{pkg_name.capitalize} renamed to #{pkg_rename.capitalize}".lightgreen
    next x
  end
  @installed_packages = keep_keys(fixup_json['installed_packages'], ['name']).flat_map(&:values).to_set
end

if renamed_packages
  FileUtils.cp File.join(CREW_CONFIG_PATH, 'device.json'), File.join(CREW_CONFIG_PATH, 'device.json.bak')
  File.write File.join(CREW_CONFIG_PATH, 'device.json.new'), JSON.pretty_generate(JSON.parse(fixup_json.to_json))
  FileUtils.cp File.join(CREW_CONFIG_PATH, 'device.json.new'), File.join(CREW_CONFIG_PATH, 'device.json')
  # Reload json file.
  fixup_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
  # Ok to remove backup and temporary json files.
  FileUtils.rm_f File.join(CREW_CONFIG_PATH, 'device.json.bak')
  FileUtils.rm_f File.join(CREW_CONFIG_PATH, 'device.json.new')
end

# Handle deprecated package deletions.
installed_fixup_packages.each do |fixup_pkg|
  working_pkg = pkg_update_arr.select { |i| i[:pkg_name] == fixup_pkg }
  delete_package = working_pkg[0][:pkg_deprecated]
  next unless delete_package

  pkg_name = working_pkg[0][:pkg_name]
  comments = working_pkg[0][:comments]
  puts "#{pkg_name.capitalize} is deprecated and should be removed. #{comments.nil? ? '' : "(#{comments})"}".lightpurple
  if Package.agree_default_yes("\nWould you like to remove deprecated package #{pkg_name.capitalize}")
    # Create a minimal Package object and pass it to Command.remove
    pkg_object = Package
    pkg_object.instance_eval do
      self.name = pkg_name
      def self.preremove; end
      def self.postremove; end
    end
    Command.remove(pkg_object, CREW_VERBOSE)
  else
    puts "#{pkg_name.capitalize} not removed.".lightblue
  end
end

# Remove pagerenv tmp file in CREW_PACKAGES_PATH if it exists
FileUtils.rm "#{CREW_PACKAGES_PATH}/pagerenv" if File.file?("#{CREW_PACKAGES_PATH}/pagerenv")

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
