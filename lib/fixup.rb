# lib/fixup.rb
# Add fixups to be run during crew update here.

CREW_VERBOSE = ARGV.intersect?(%w[-v --verbose]) unless defined?(CREW_VERBOSE)

# remove deprecated directory
FileUtils.rm_rf "#{HOME}/.cache/crewcache/manifest"

# Remove install.sh provided path file since we supersede it.
if File.exist?("#{CREW_PREFIX}/etc/env.d/00-path") && File.exist?("#{CREW_PREFIX}/etc/env.d/path")
  puts "Removing #{CREW_PREFIX}/etc/env.d/path installed by the Chromebrew installer.\n".orange
  FileUtils.rm "#{CREW_PREFIX}/etc/env.d/path"
end

# Set new sparse-checkout paths for commands directory
Dir.chdir CREW_LIB_PATH do
  system 'git sparse-checkout add commands'
  system 'git sparse-checkout reapply'
end

# Rename the binary_sha256 variable to sha256 in the device.json file
system(" sed -i 's/binary_sha256/sha256/g' #{File.join(CREW_CONFIG_PATH, 'device.json')}")

# Check for renamed and deprecated packages, and handle them.

def pkg_deprecated(name, comments: nil)
  return unless PackageUtils.installed?(name)
  puts "\n#{name} found in package fixup list".lightcyan
  puts "#{name} is deprecated and should be removed.".lightpurple
  puts "#{name}: #{comments}".lightpurple unless comments.to_s.empty?
  print "\nWould you like to remove deprecated package #{name}? [y/N] "
  case $stdin.gets.chomp.downcase
  when 'y', 'yes'
    # Create a minimal Package object and pass it to Command.remove
    pkg_object = Package
    pkg_object.instance_eval do
      self.name = name
      def self.preremove; end
      def self.remove; end
    end
    Command.remove(pkg_object, CREW_VERBOSE)
  else
    puts "#{name} not removed.".lightblue
  end
end

def pkg_rename(name, new_name, comments: nil)
  return unless PackageUtils.installed?(name)
  # Package rename.
  puts "\n#{name} found in package fixup list".lightcyan
  puts "#{name} has been renamed to #{new_name}".lightpurple
  puts "#{name}: #{comments}".lightpurple unless comments.to_s.empty?

  old_filelist = File.join(CREW_META_PATH, "#{name}.filelist")
  new_filelist = File.join(CREW_META_PATH, "#{new_name}.filelist")
  old_directorylist = File.join(CREW_META_PATH, "#{name}.directorylist")
  new_directorylist = File.join(CREW_META_PATH, "#{new_name}.directorylist")
  # Handle case of new package already installed.
  if PackageUtils.installed?(new_name)
    puts "Renamed #{new_name} is already installed. Deleting old package (#{new_name}) information...".lightblue
    FileUtils.rm_f old_filelist
    FileUtils.rm_f old_directorylist
    @device[:installed_packages].delete_if { |elem| elem[:name] == name }
    File.write "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(JSON.parse(@device.to_json))
    return
  end
  # Handle case of package needing to be replaced.
  if File.file?(new_filelist)
    puts "new filelist for #{new_name} already exists!"
    return
  end
  if File.file?(new_directorylist)
    puts "new directorylist for #{new_name} already exists!"
    return
  end
  # If new filelist or directorylist do not exist and new package is not
  # marked as installed in device.json then rename and edit device.json .
  begin
    FileUtils.cp "#{CREW_CONFIG_PATH}/device.json", "#{CREW_CONFIG_PATH}/device.json.bak"
    FileUtils.mv old_filelist, new_filelist
    FileUtils.mv old_directorylist, new_directorylist
    @device[:installed_packages].map do |x|
      x[:name] = new_name if x[:name] == name
      next x
    end
    File.write "#{CREW_CONFIG_PATH}/device.json.new", JSON.pretty_generate(JSON.parse(@device.to_json))
    @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json.new", symbolize_names: true)
    @device.transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
    raise StandardError, 'Failed to replace pkg name...'.lightred unless @device[:installed_packages].any? { |elem| elem[:name] == new_name }
    # Ok to write working device.json
    File.write "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(JSON.parse(@device.to_json))
    puts "#{name} renamed to #{new_name}".lightgreen
  rescue StandardError
    puts 'Restoring old filelist, directorylist, and device.json...'.lightred
    FileUtils.mv new_filelist, old_filelist
    FileUtils.mv new_directorylist, old_directorylist
    FileUtils.cp "#{CREW_CONFIG_PATH}/device.json.bak", "#{CREW_CONFIG_PATH}/device.json"
  end
  # Reload json file.
  @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
  @device.transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
  # Ok to remove backup and temporary json files.
  FileUtils.rm_f "#{CREW_CONFIG_PATH}/device.json.bak"
  FileUtils.rm_f "#{CREW_CONFIG_PATH}/device.json.new"
end

pkg_deprecated('git_prompt', comments: 'Integrated into git package.')
pkg_deprecated('gnome_session', comments: 'No longer compatible with any architecture, requires systemd.')
pkg_deprecated('gnome_settings_daemon', comments: 'No longer compatible with any architecture, requires systemd.')
pkg_deprecated('gnome_shell', comments: 'No longer compatible with any architecture, requires systemd.')
pkg_deprecated('gnome_tweaks', comments: 'No longer compatible with any architecture, requires systemd in dep package gnome_settings_daemon.')
pkg_deprecated('ilmbase', comments: 'Included in openexr.')
pkg_deprecated('js91', comments: 'Replaced by newer versions of js.')
pkg_deprecated('libmfx', comments: 'No longer compatible with any architecture')
pkg_deprecated('linter', comments: 'Replaced with py3_pre_commit.')
pkg_deprecated('nping', comments: 'Removed to avoid conflict with nmap.')
pkg_deprecated('qtchooser', comments: "Doesn't work for newer Qt versions.")

pkg_deprecated('ruby_debug', comments: 'Integrated into ruby package.')
pkg_rename('acli', 'acquia_cli', comments: 'Renamed to better match upstream.')
pkg_rename('agrind', 'angle_grinder', comments: 'Renamed to better match upstream.')
pkg_rename('apriconv', 'apr_iconv', comments: 'Renamed to better match upstream.')
pkg_rename('aprutil', 'apr_util', comments: 'Renamed to better match upstream.')
pkg_rename('arpscan', 'arp_scan', comments: 'Renamed to better match upstream.')
pkg_rename('aws', 'aws_cli', comments: 'Renamed to better match upstream.')
pkg_rename('btrfsprogs', 'btrfs_progs', comments: 'Renamed to better match upstream.')
pkg_rename('bz2', 'bzip2', comments: 'Renamed to better match upstream.')
pkg_rename('bz3', 'bzip3', comments: 'Renamed to better match upstream.')
pkg_rename('codium', 'vscodium', comments: 'Renamed to better match upstream.')
pkg_rename('ffcall', 'libffcall', comments: 'Renamed to better match upstream.')
pkg_rename('jsonc', 'json_c', comments: 'Renamed to better match upstream.')
pkg_rename('libcurl', 'curl')
pkg_rename('libjpeg', 'libjpeg_turbo', comments: 'Renamed to better match upstream.')
pkg_rename('mandb', 'man_db', comments: 'Renamed to better match upstream.')
pkg_rename('mercurial', 'py3_mercurial', comments: 'Renamed to match other pip packages.')
pkg_rename('meson', 'mesonbuild', comments: 'Renamed to avoid conflict with buildsystems/meson.')
pkg_rename('moonbuggy', 'moon_buggy', comments: 'Renamed to better match upstream.')
pkg_rename('pkgconfig', 'pkg_config', comments: 'Renamed to better match upstream.')
pkg_rename('postgres', 'postgresql', comments: 'Renamed to better match upstream.')
pkg_rename('proj4', 'proj', comments: 'Renamed to better match upstream.')
pkg_rename('qtbase', 'qt5_base', comments: 'Qt packages renamed to qt5_*')
pkg_rename('qtcharts', 'qt5_charts')
pkg_rename('qtdeclarative', 'qt5_declarative')
pkg_rename('qtimageformats', 'qt5_imageformats')
pkg_rename('qtlocation', 'qt5_location')
pkg_rename('qtmultimedia', 'qt5_multimedia')
pkg_rename('qtquickcontrols', 'qt5_quickcontrols')
pkg_rename('qtscript', 'qt5_script')
pkg_rename('qtserialport', 'qt5_serialport')
pkg_rename('qtsvg', 'qt5_svg')
pkg_rename('qttools', 'qt5_tools')
pkg_rename('qtwayland', 'qt5_wayland')
pkg_rename('qtwebchannel', 'qt5_webchannel')
pkg_rename('qtwebengine', 'qt5_webengine')
pkg_rename('qtwebglplugin', 'qt5_webglplugin')
pkg_rename('qtwebsockets', 'qt5_websockets')
pkg_rename('qtx11extras', 'qt5_x11extras')
pkg_rename('wget', 'wget2', comments: 'Renamed to better match upstream.')

# Restart crew update if the git commit of const.rb loaded in const.rb
# is different from the git commit of the potentially updated const.rb
# loaded here after a git pull.

# Handle case of const.rb not yet defining CREW_CONST_GIT_COMMIT.
CREW_CONST_GIT_COMMIT = '0000' unless defined?(CREW_CONST_GIT_COMMIT)

Dir.chdir CREW_LIB_PATH do
  @new_const_git_commit = `git log -n1 --oneline #{CREW_LIB_PATH}/lib/const.rb`.chomp.split.first
end

unless @new_const_git_commit == CREW_CONST_GIT_COMMIT
  puts 'Restarting crew update since there is an updated crew version.'.lightcyan
  puts "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update".orange if CREW_VERBOSE
  exec "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update"
end

# Remove pagerenv tmp file in CREW_PACKAGES_PATH if it exists
FileUtils.rm "#{CREW_PACKAGES_PATH}/pagerenv" if File.file?("#{CREW_PACKAGES_PATH}/pagerenv")
