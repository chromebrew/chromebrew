# Add fixups to be run during crew update here.

# remove deprecated directory
FileUtils.rm_rf "#{HOME}/.cache/crewcache/manifest"

# Fix missing $PATH not added in install.sh
if !system("grep -q '$PATH' #{CREW_PREFIX}/etc/env.d/path") || Gem::Version.new(CREW_VERSION.to_s) < Gem::Version.new('1.36.4')
  puts 'Fixing path env.d file...'.orange
  puts "Please run 'source ~/.bashrc'".lightblue
  File.write "#{CREW_PREFIX}/etc/env.d/path", <<~ENVD_PATH_EOF
    ## Inserted by Chromebrew version #{CREW_VERSION}
    PATH=#{CREW_PREFIX}/bin:#{CREW_PREFIX}/sbin:#{CREW_PREFIX}/share/musl/bin:$PATH
  ENVD_PATH_EOF
end

# Check for renamed and deprecated packages, and handle them.

pkg_update_arr = [
  { pkg_name: 'libcurl', pkg_rename: 'curl', pkg_deprecated: nil },
  { pkg_name: 'meson', pkg_rename: 'mesonbuild', pkg_deprecated: nil },
  { pkg_name: 'qtbase', pkg_rename: 'qt5_base', pkg_deprecated: nil },
  { pkg_name: 'qtcharts', pkg_rename: 'qt5_charts', pkg_deprecated: nil },
  { pkg_name: 'qtdeclarative', pkg_rename: 'qt5_declarative', pkg_deprecated: nil },
  { pkg_name: 'qtimageformats', pkg_rename: 'qt5_imageformats', pkg_deprecated: nil },
  { pkg_name: 'qtlocation', pkg_rename: 'qt5_location', pkg_deprecated: nil },
  { pkg_name: 'qtmultimedia', pkg_rename: 'qt5_multimedia', pkg_deprecated: nil },
  { pkg_name: 'qtquickcontrols', pkg_rename: 'qt5_quickcontrols', pkg_deprecated: nil },
  { pkg_name: 'qtscript', pkg_rename: 'qt5_script', pkg_deprecated: nil },
  { pkg_name: 'qtserialport', pkg_rename: 'qt5_serialport', pkg_deprecated: nil },
  { pkg_name: 'qtsvg', pkg_rename: 'qt5_svg', pkg_deprecated: nil },
  { pkg_name: 'qttools', pkg_rename: 'qt5_tools', pkg_deprecated: nil },
  { pkg_name: 'qtwayland', pkg_rename: 'qt5_wayland', pkg_deprecated: nil },
  { pkg_name: 'qtwebchannel', pkg_rename: 'qt5_webchannel', pkg_deprecated: nil },
  { pkg_name: 'qtwebengine', pkg_rename: 'qt5_webengine', pkg_deprecated: nil },
  { pkg_name: 'qtwebglplugin', pkg_rename: 'qt5_webglplugin', pkg_deprecated: nil },
  { pkg_name: 'qtwebsockets', pkg_rename: 'qt5_websockets', pkg_deprecated: nil },
  { pkg_name: 'qtx11extras', pkg_rename: 'qt5_x11extras', pkg_deprecated: nil },
  { pkg_name: 'qtchooser', pkg_rename: nil, pkg_deprecated: true }
]

#begin
  #gem 'active_support'
#rescue Gem::LoadError
  #puts ' -> installing gem activesupport'.orange
  #Gem.install('activesupport')
  #gem 'activesupport'
#end
#require 'active_support/core_ext/object/blank'

pkg_update_arr.each do |pkg|
  next unless @device[:installed_packages].any? { |elem| elem[:name] == pkg[:pkg_name] }

  puts "#{pkg[:pkg_name]} found in package fixup list".orange

  # Package rename.
  unless pkg[:pkg_rename].to_s.empty?
    puts "#{pkg[:pkg_name]} is being renamed to #{pkg[:pkg_rename]}".orange
    # maybe put this in a function? e.g.,
    # rename_pkg pkg[:pkg_name] pkg[:pkg_rename]
    old_filelist = File.join(CREW_META_PATH, "#{pkg[:pkg_name]}.filelist")
    new_filelist = File.join(CREW_META_PATH, "#{pkg[:pkg_rename]}.filelist")
    old_directorylist = File.join(CREW_META_PATH, "#{pkg[:pkg_name]}.directorylist")
    new_directorylist = File.join(CREW_META_PATH, "#{pkg[:pkg_rename]}.directorylist")
    # Handle case of new package already installed.
    if @device[:installed_packages].any? { |elem| elem[:name] == pkg[:pkg_rename] }
      puts "Renamed #{pkg[:pkg_rename]} is already installed. Deleting old package (#{pkg[:pkg_rename]}) information...".lightblue
      FileUtils.rm old_filelist if File.file?(old_filelist)
      FileUtils.rm old_directorylist if File.file?(old_directorylist)
      @device[:installed_packages].delete_if { |elem| elem[:name] == pkg[:pkg_name] }
      File.write "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(JSON.parse(@device.to_json))
      next
    end
    # Handle case of package needing to be replaced.
    if File.file?(new_filelist)
      puts "new filelist for #{pkg[:pkg_rename]} already exists!"
      next
    end
    if File.file?(new_directorylist)
      puts "new directorylist for #{pkg[:pkg_rename]} already exists!"
      next
    end
    # If new filelist or directorylist do not exist and new package is not
    # marked as installed in device.json then rename and edit device.json .
    puts "Renaming #{pkg[:pkg_name]} to #{pkg[:pkg_rename]}".lightblue
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
    rescue StandardError => e
      puts 'Restoring old filelist, directorylist, and device.json...'.lightred
      FileUtils.mv new_filelist, old_filelist
      FileUtils.mv new_directorylist, old_directorylist
      FileUtils.cp "#{CREW_CONFIG_PATH}/device.json.bak", "#{CREW_CONFIG_PATH}/device.json"
      # Reload json file.
      @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
      @device.transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
    end
    # Reload json file.
    @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
    @device.transform_values! {|val| val.is_a?(String) ? val.to_sym : val }
    # Ok to remove backup and temporary json files.
    FileUtils.rm_f "#{CREW_CONFIG_PATH}/device.json.bak"
    FileUtils.rm_f "#{CREW_CONFIG_PATH}/device.json.new"
  end

  # Deprecated package deletion.
  puts "#{pkg[:pkg_name]} is deprecated and should be removed.".orange if pkg[:pkg_deprecated]
end
