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

begin
  gem 'active_support'
rescue Gem::LoadError
  puts ' -> installing gem activesupport'.orange
  Gem.install('activesupport')
  gem 'activesupport'
end
require 'active_support/core_ext/object/blank'

pkg_update_arr.each do |pkg|
  next unless @device[:installed_packages].any? { |elem| elem[:name] == pkg[:pkg_name] }

  puts "#{pkg[:pkg_name]} found in package fixup list".orange
  puts "Rename #{pkg[:pkg_name]} to #{pkg[:pkg_rename]}".orange unless pkg[:pkg_rename].blank?
  puts "#{pkg[:pkg_name]} is deprecated and should be removed.".orange if pkg[:pkg_deprecated]
end
