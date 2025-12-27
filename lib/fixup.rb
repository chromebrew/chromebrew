# lib/fixup.rb
# Add fixups to be run during crew update here.
require 'fileutils'
require 'json'
require_relative 'color'
require_relative 'const'
require_relative 'convenience_functions'
require_relative 'package'

# Commands run immediately after updating from git.

# Set the mtime on each file to the timestamp of the most recent commit that modified the file.
system('git-restore-mtime -sq 2>/dev/null', chdir: CREW_LIB_PATH, exception: true) if File.file?("#{CREW_PREFIX}/bin/git-restore-mtime")

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

# Rename the binary_sha256 variable to sha256 in the device.json file
system("sed -i 's/binary_sha256/sha256/g' #{File.join(CREW_CONFIG_PATH, 'device.json')}")

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
  { pkg_name: 'gnome_themes_standard', pkg_rename: 'gnome_themes_extra', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'gtk_engines_adwaita', pkg_rename: 'gnome_themes_extra', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'itstool', pkg_rename: 'py3_itstool', comments: 'Renamed to indicate switch to pip buildsystem.' },
  { pkg_name: 'jsonc', pkg_rename: 'json_c', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libcurl', pkg_rename: 'curl', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libxfont', pkg_rename: 'libxfont2', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libgnome_games_support2', pkg_rename: 'libgnome_games_support', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libgpgerror', pkg_rename: 'libgpg_error', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libjpeg', pkg_rename: 'libjpeg_turbo', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'libsdl2', pkg_rename: 'sdl2', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'mandb', pkg_rename: 'man_db', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'mercurial', pkg_rename: 'py3_mercurial', comments: 'Renamed to match other pip packages.' },
  { pkg_name: 'meson', pkg_rename: 'py3_meson', comments: 'Renamed to avoid conflict with buildsystems/meson.' },
  { pkg_name: 'mesonbuild', pkg_rename: 'py3_meson', comments: 'Renamed to indicate switch to pip buildsystem.' },
  { pkg_name: 'moonbuggy', pkg_rename: 'moon_buggy', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'oci_cli', pkg_rename: 'py3_oci_cli', comments: 'Fix to match upstream name.' },
  { pkg_name: 'onepassword', pkg_rename: 'onepassword_cli', comments: 'Rename to distinguish between onepassword_gui.' },
  { pkg_name: 'perl_locale_messages', pkg_rename: 'perl_libintl_perl', comments: 'Renamed to identify perl package.' },
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
  { pkg_name: 'scons', pkg_rename: 'py3_scons', comments: 'Renamed to match pip package name.' },
  { pkg_name: 'tracker3', pkg_rename: 'tinysparql', comments: 'Renamed upstream.' },
  { pkg_name: 'tracker3_miners', pkg_rename: 'localsearch', comments: 'Renamed upstream.' },
  { pkg_name: 'util_macros', pkg_rename: 'xorg_macros', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'wget', pkg_rename: 'wget2', comments: 'Renamed to better match upstream.' },
  { pkg_name: 'zlibpkg', pkg_rename: 'zlib', comments: 'Renamed to better match upstream.' }
]

unless CREW_PRE_GLIBC_STANDALONE
  renamed_packages << { pkg_name: 'glibc_dev', pkg_rename: 'glibc', comments: 'Renamed to better match upstream.' }
  renamed_packages << { pkg_name: 'glibc_lib', pkg_rename: 'glibc', comments: 'Renamed to better match upstream.' }
  renamed_packages << { pkg_name: 'glibc_standalone', pkg_rename: 'glibc', comments: 'Renamed to better match upstream.' }
end

deprecated_packages = Set[
  { pkg_name: 'epydoc', comments: 'Abandoned upstream, only supports Python 2.' },
  { pkg_name: 'extremetuxracer', comments: 'Chromebrew version had broken links to missing pre-compiled binaries.' },
  { pkg_name: 'gfbgraph', commwnts: 'Deprecated upstream.' },
  { pkg_name: 'git_prompt', comments: 'Integrated into git package.' },
  { pkg_name: 'glproto', comments: 'Deprecated upstream.' },
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
  { pkg_name: 'libcheck', comments: 'Replaced by identical existing package check.' },
  { pkg_name: 'libgc', comments: 'Mislabelled duplicate of bdwgc.' },
  { pkg_name: 'libmfx', comments: 'No longer compatible with any architecture' },
  { pkg_name: 'linter', comments: 'Replaced with py3_pre_commit.' },
  { pkg_name: 'nping', comments: 'Removed to avoid conflict with nmap.' },
  { pkg_name: 'openjdk22', comments: 'Deprecated upstream.' },
  { pkg_name: 'openjdk23', comments: 'Deprecated upstream.' },
  { pkg_name: 'openjdk24', comments: 'Deprecated upstream.' },
  { pkg_name: 'percona_boost', comments: 'Replaced by regular boost.' },
  { pkg_name: 'percona_server', comments: 'Replaced by mysql.' },
  { pkg_name: 'printproto', comments: 'Deprecated upstream.' },
  { pkg_name: 'py3_zcmds', comments: 'Removed due to broken builds.' },
  { pkg_name: 'q', comments: 'No longer suitable for packaging.' },
  { pkg_name: 'qtchooser', comments: "Doesn't work for newer Qt versions." },
  { pkg_name: 'skype', comments: 'Officially sunsetting and will be shut down soon.' }
]

unless CREW_PRE_GLIBC_STANDALONE
  deprecated_packages << { pkg_name: 'glibc_build223', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_build227', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_build232', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_build233', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_build235', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_build237', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_dev223', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_dev227', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_dev232', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_dev233', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_dev235', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_dev237', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_fallthrough', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_lib223', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_lib227', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_lib232', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_lib233', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_lib235', comments: 'We are moving away from system glibc.' }
  deprecated_packages << { pkg_name: 'glibc_lib237', comments: 'We are moving away from system glibc.' }
end

# Load device.json and get an array of the currently installed packages.
device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
installed_packages = device_json['installed_packages'].map { it['name'] }

# Handle package renames.
# TODO: This currently does not handle fake packages very well.
renamed_pkgs = renamed_packages.map { it[:pkg_name] }
installed_pkgs_to_rename = installed_packages & renamed_pkgs

installed_pkgs_to_rename.each do |fixup_pkg|
  working_pkg = renamed_packages.find { it[:pkg_name] == fixup_pkg }
  pkg_name = working_pkg[:pkg_name]
  pkg_rename = working_pkg[:pkg_rename]

  puts "#{pkg_name.capitalize} has been renamed to #{pkg_rename.capitalize}. #{working_pkg[:comments]}".lightpurple

  old_filelist = File.join(CREW_META_PATH, "#{pkg_name}.filelist")
  new_filelist = File.join(CREW_META_PATH, "#{pkg_rename}.filelist")
  old_directorylist = File.join(CREW_META_PATH, "#{pkg_name}.directorylist")
  new_directorylist = File.join(CREW_META_PATH, "#{pkg_rename}.directorylist")

  # Handle the case of the new package already being installed.
  if installed_packages.include?(pkg_rename)
    puts "Renamed #{pkg_rename.capitalize} is already installed. Deleting old package (#{pkg_rename.capitalize}) information...".lightblue

    FileUtils.rm_f [old_filelist, old_directorylist]

    device_json['installed_packages'].delete_if { it['name'] == pkg_name }
    installed_packages.delete(pkg_name)
    next
  end

  # Handle the case of a package needing to be replaced.
  if File.file?(new_filelist)
    puts "New filelist for #{pkg_rename.capitalize} already exists!"
    next
  end

  if File.file?(new_directorylist)
    puts "New directorylist for #{pkg_rename.capitalize} already exists!"
    next
  end

  # If we are here, rename the filelists and rename the package in device.json
  FileUtils.mv old_filelist, new_filelist
  FileUtils.mv old_directorylist, new_directorylist

  device_json['installed_packages'][installed_packages.index(pkg_name)]['name'] = pkg_rename
  installed_packages[installed_packages.index(pkg_name)] = pkg_rename
end

# Write our changes to device.json now, because Command.remove will load it personally.
ConvenienceFunctions.save_json(device_json)

# Handle deprecated packages.
deprecated_pkgs = deprecated_packages.map { it[:pkg_name] }
installed_pkgs_to_deprecate = installed_packages & deprecated_pkgs

installed_pkgs_to_deprecate.each do |fixup_pkg|
  working_pkg = deprecated_packages.find { it[:pkg_name] == fixup_pkg }
  pkg_name = working_pkg[:pkg_name]

  puts "#{pkg_name.capitalize} is deprecated and should be removed. #{working_pkg[:comments]}".lightpurple

  if Package.agree_default_yes("\nWould you like to remove deprecated package #{pkg_name.capitalize}")
    # Create a minimal Package object and pass it to Command.remove
    pkg_object = Package
    pkg_object.name = pkg_name

    Command.remove(pkg_object, verbose: CREW_VERBOSE, force: !CREW_PRE_GLIBC_STANDALONE, only_remove_files: true)
  else
    puts "#{pkg_name.capitalize} was not removed.".lightblue
  end
end

if File.exist?("#{CREW_PREFIX}/bin/upx") && File.exist?("#{CREW_PREFIX}/bin/patchelf")
  abort("No Upx found! Please run 'crew install upx'").lightred unless File.file?("#{CREW_PREFIX}/bin/upx")
  abort("No Patchelf found! Please run 'crew install patchelf'").lightred unless File.file?("#{CREW_PREFIX}/bin/patchelf")
  # Using xargs to spawn parallel processes since spawning parallel
  # processes using ruby gems like concurrent ruby leads to out of memory
  # errors on arm.
  # Running find twice because it involves less ruby overhead than saving
  # the output in memory, and also doing that in ruby is VERY SLOW.
  puts 'Please wait while upx is run to uncompress binaries...'.lightblue unless CREW_UNATTENDED
  Kernel.system "#{CREW_PREFIX}/bin/find #{CREW_PREFIX}/bin -type f -print0 | xargs -0 -P#{CREW_NPROC} -n1 -r bash -c 'header=$(head -c4 ${0}); elfheader='$(printf '\\\177ELF')' ; arheader=\\!\\<ar ; case $header in $elfheader|$arheader) upx -qq -d ${0} ;; esac'", %i[err] => File::NULL, exception: false

  unless CREW_GLIBC_INTERPRETER.blank?
    puts 'Please wait while patchelf is run to patch binary interpreter and rpath if needed...'.lightblue
    if CREW_VERBOSE
      Kernel.system "#{CREW_PREFIX}/bin/find #{CREW_PREFIX}/bin #{CREW_LIB_PREFIX} -type f ! -name '*.a' ! -name '*.o' ! -name '*.gox' -print0 | xargs -0 -P#{CREW_NPROC} -n1 -r bash -c 'header=$(head -c4 ${0}); elfheader='$(printf '\\\177ELF')' ; arheader=\\!\\<ar ; case $header in $elfheader|$arheader) patchelf --set-interpreter #{CREW_GLIBC_INTERPRETER} ${0} ; exec_rpath=$(patchelf --print-rpath ${0}) ; echo \"exec_rpath ${0}: \$exec_rpath\" ; if [[ -n \$exec_rpath ]] && [[ \$exec_rpath != *\"#{CREW_GLIBC_PREFIX}\"* ]]; then echo \"Will attempt to adjust rpath for ${0}...\" ; patchelf --set-rpath #{CREW_GLIBC_PREFIX}:\${exec_rpath} ${0}; fi ; if [[ -z \$exec_rpath ]]; then echo \"Will attempt to set rpath for ${0}...\" ; patchelf --set-rpath #{CREW_GLIBC_PREFIX} ${0}; fi ;; esac'", %i[err] => File::NULL, exception: false
    else
      Kernel.system "#{CREW_PREFIX}/bin/find #{CREW_PREFIX}/bin #{CREW_LIB_PREFIX} -type f ! -name '*.a' ! -name '*.o' ! -name '*.gox' -print0 | xargs -0 -P#{CREW_NPROC} -n1 -r bash -c 'header=$(head -c4 ${0}); elfheader='$(printf '\\\177ELF')' ; arheader=\\!\\<ar ; case $header in $elfheader|$arheader) patchelf --set-interpreter #{CREW_GLIBC_INTERPRETER} ${0} ; exec_rpath=$(patchelf --print-rpath ${0}) ; if [[ -n \$exec_rpath ]] && [[ \$exec_rpath != *\"#{CREW_GLIBC_PREFIX}\"* ]]; then patchelf --set-rpath #{CREW_GLIBC_PREFIX}:\${exec_rpath} ${0}; fi ; if [[ -z \$exec_rpath ]]; then patchelf --set-rpath #{CREW_GLIBC_PREFIX} ${0}; fi ;; esac'", %i[err] => File::NULL, exception: false
    end
  end
else
  abort 'Please install upx and patchelf first by running \'crew install upx patchelf\'.'.lightred
end
