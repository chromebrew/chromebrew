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

pkg_update_arr = [
  { pkg_name: 'acli', pkg_rename: 'acquia_cli', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'agrind', pkg_rename: 'angle_grinder', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'apriconv', pkg_rename: 'apr_iconv', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aprutil', pkg_rename: 'apr_util', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aws', pkg_rename: 'aws_cli', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz2', pkg_rename: 'bzip2', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz3', pkg_rename: 'bzip3', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'codium', pkg_rename: 'vscodium', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'ffcall', pkg_rename: 'libffcall', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'git_prompt', pkg_rename: nil, pkg_deprecated: true, comments: 'Integrated into git package.' },
  { pkg_name: 'gnome_session', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_settings_daemon', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_shell', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd.' },
  { pkg_name: 'gnome_tweaks', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture, requires systemd in dep package gnome_settings_daemon.' },
  { pkg_name: 'ilmbase', pkg_rename: nil, pkg_deprecated: true, comments: 'Included in openexr.' },
  { pkg_name: 'js91', pkg_rename: nil, pkg_deprecated: true, comments: 'Replaced by newer versions of js.' },
  { pkg_name: 'libcurl', pkg_rename: 'curl', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'libmfx', pkg_rename: nil, pkg_deprecated: true, comments: 'No longer compatible with any architecture' },
  { pkg_name: 'mercurial', pkg_rename: 'py3_mercurial', pkg_deprecated: nil, comments: 'Renamed to match other pip packages.' },
  { pkg_name: 'meson', pkg_rename: 'mesonbuild', pkg_deprecated: nil, comments: 'Renamed to avoid conflict with buildsystems/meson.' },
  { pkg_name: 'nping', pkg_rename: nil, pkg_deprecated: true, comments: 'Removed to avoid conflict with nmap.' },
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
  { pkg_name: 'wget', pkg_rename: 'wget2', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' }
]

pkg_update_arr.each do |pkg|
  next unless @device[:installed_packages].any? { |elem| elem[:name] == pkg[:pkg_name] }

  puts "\n#{pkg[:pkg_name].capitalize} found in package fixup list".lightcyan

  # Package rename.
  unless pkg[:pkg_rename].to_s.empty?
    puts "#{pkg[:pkg_name].capitalize} has been renamed to #{pkg[:pkg_rename].capitalize}".lightpurple
    puts "#{pkg[:pkg_name].capitalize}: #{pkg[:comments]}".lightpurple unless pkg[:comments].to_s.empty?

    old_filelist = File.join(CREW_META_PATH, "#{pkg[:pkg_name]}.filelist")
    new_filelist = File.join(CREW_META_PATH, "#{pkg[:pkg_rename]}.filelist")
    old_directorylist = File.join(CREW_META_PATH, "#{pkg[:pkg_name]}.directorylist")
    new_directorylist = File.join(CREW_META_PATH, "#{pkg[:pkg_rename]}.directorylist")
    # Handle case of new package already installed.
    if @device[:installed_packages].any? { |elem| elem[:name] == pkg[:pkg_rename] }
      puts "Renamed #{pkg[:pkg_rename].capitalize} is already installed. Deleting old package (#{pkg[:pkg_rename].capitalize}) information...".lightblue
      FileUtils.rm_f old_filelist
      FileUtils.rm_f old_directorylist
      @device[:installed_packages].delete_if { |elem| elem[:name] == pkg[:pkg_name] }
      File.write "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(JSON.parse(@device.to_json))
      next
    end
    # Handle case of package needing to be replaced.
    if File.file?(new_filelist)
      puts "new filelist for #{pkg[:pkg_rename].capitalize} already exists!"
      next
    end
    if File.file?(new_directorylist)
      puts "new directorylist for #{pkg[:pkg_rename].capitalize} already exists!"
      next
    end
    # If new filelist or directorylist do not exist and new package is not
    # marked as installed in device.json then rename and edit device.json .
    begin
      FileUtils.cp "#{CREW_CONFIG_PATH}/device.json", "#{CREW_CONFIG_PATH}/device.json.bak"
      FileUtils.mv old_filelist, new_filelist
      FileUtils.mv old_directorylist, new_directorylist
      @device[:installed_packages].map do |x|
        x[:name] = pkg[:pkg_rename] if x[:name] == pkg[:pkg_name]
        next x
      end
      File.write "#{CREW_CONFIG_PATH}/device.json.new", JSON.pretty_generate(JSON.parse(@device.to_json))
      @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json.new", symbolize_names: true)
      @device.transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
      raise StandardError, 'Failed to replace pkg name...'.lightred unless @device[:installed_packages].any? { |elem| elem[:name] == pkg[:pkg_rename] }
      # Ok to write working device.json
      File.write "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(JSON.parse(@device.to_json))
      puts "#{pkg[:pkg_name].capitalize} renamed to #{pkg[:pkg_rename].capitalize}".lightgreen
    rescue StandardError
      puts 'Restoring old filelist, directorylist, and device.json...'.lightred
      FileUtils.mv new_filelist, old_filelist
      FileUtils.mv new_directorylist, old_directorylist
      FileUtils.cp "#{CREW_CONFIG_PATH}/device.json.bak", "#{CREW_CONFIG_PATH}/device.json"
    end
    # Reload json file.
    @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
    @device.transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
    # Ok to remove backup and temporary json files.
    FileUtils.rm_f "#{CREW_CONFIG_PATH}/device.json.bak"
    FileUtils.rm_f "#{CREW_CONFIG_PATH}/device.json.new"
  end

  # Deprecated package deletion.
  next if pkg[:pkg_deprecated].to_s.empty?
  puts "#{pkg[:pkg_name].capitalize} is deprecated and should be removed.".lightpurple
  puts "#{pkg[:pkg_name].capitalize}: #{pkg[:comments]}".lightpurple unless pkg[:comments].to_s.empty?
  print "\nWould you like to remove deprecated package #{pkg[:pkg_name].capitalize}? [y/N] "
  case $stdin.gets.chomp.downcase
  when 'y', 'yes'
    # Create a minimal Package object and pass it to Command.remove
    pkg_object = Package
    pkg_object.instance_eval do
      self.name = pkg[:pkg_name]
      def self.preremove; end
      def self.remove; end
    end
    Command.remove(pkg_object, CREW_VERBOSE)
  else
    puts "#{pkg[:pkg_name].capitalize} not removed.".lightblue
  end
end

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
