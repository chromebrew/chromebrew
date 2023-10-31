# lib/fixup.rb
# Add fixups to be run during crew update here.

# remove deprecated directory
FileUtils.rm_rf "#{HOME}/.cache/crewcache/manifest"

# Fix missing $PATH not added in install.sh
if !system("grep -q '$PATH' #{CREW_PREFIX}/etc/env.d/path") || Gem::Version.new(CREW_VERSION.to_s) < Gem::Version.new('1.36.4')
  File.write "#{CREW_PREFIX}/etc/env.d/path", <<~ENVD_PATH_EOF
    ## Inserted by Chromebrew version #{CREW_VERSION}
    PATH=#{CREW_PREFIX}/bin:#{CREW_PREFIX}/sbin:#{CREW_PREFIX}/share/musl/bin:$PATH
  ENVD_PATH_EOF
  ExitMessage.add "Fixed path env.d file...\nPlease run 'source ~/.bashrc'".orange
end

# Check for renamed and deprecated packages, and handle them.

pkg_update_arr = [
  { pkg_name: 'libcurl', pkg_rename: 'curl', pkg_deprecated: nil, comments: nil },
  { pkg_name: 'meson', pkg_rename: 'mesonbuild', pkg_deprecated: nil, comments: 'Renamed to avoid conflict with buildsystems/meson.' },
  { pkg_name: 'qtbase', pkg_rename: 'qt5_base', pkg_deprecated: nil, comments: 'Qt packages renamed to qt5_*' },
  { pkg_name: 'qtcharts', pkg_rename: 'qt5_charts', pkg_deprecated: nil, comments: nil },
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
  { pkg_name: 'qtchooser', pkg_rename: nil, pkg_deprecated: true, comments: "Doesn't work for newer Qt versions." },
  { pkg_name: 'acli', pkg_rename: 'acquia_cli', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'agrind', pkg_rename: 'angle_grinder', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'apriconv', pkg_rename: 'apr_iconv', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'aprutil', pkg_rename: 'apr_util', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz2', pkg_rename: 'bzip2', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'bz3', pkg_rename: 'bzip3', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' },
  { pkg_name: 'codium', pkg_rename: 'vscodium', pkg_deprecated: nil, comments: 'Renamed to better match upstream.' }
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
    rescue StandardError => e
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
    @in_fixup = true
    begin
      remove pkg[:pkg_name]
    rescue NoMethodError # This won't work the first time crew update happens, since this requires an update to crew.
      puts "Please rerun 'crew update' to allow for removal of #{pkg[:pkg_name].capitalize}.".orange
      puts "#{pkg[:pkg_name].capitalize} not removed.".lightblue
    end
    @in_fixup = false
  else
    puts "#{pkg[:pkg_name].capitalize} not removed.".lightblue
  end
end

# Restart crew update if the git commit of const.rb loaded in const.rb
# is different from the git commit of the potentially updated const.rb
# loaded here after a git pull.

# Handle case of const.rb not yet defining CREW_CONST_GIT_COMMIT.
CREW_CONST_GIT_COMMIT = '0000' unless defined?(CREW_CONST_GIT_COMMIT)

@new_const_git_commit = `git log -n1 --oneline #{CREW_LIB_PATH}/lib/const.rb`.chomp.split.first

unless @new_const_git_commit.to_s == CREW_CONST_GIT_COMMIT.to_s
  puts 'Restarting crew update since there is an updated crew version.'.lightcyan
  puts "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update".orange if @opt_verbose
  exec "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update"
end

