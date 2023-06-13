require 'package'

class Ferdi < Package
  description 'All your apps in one place'
  homepage 'https://getferdi.com/'
  version '5.8.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/getferdi/ferdi/releases/download/v5.8.0/Ferdi-5.8.0.AppImage'
  source_sha256 '74e6f1f4bd7d429ac51460e4f48713d72ad9a3fbcbc8b2ecfa318dbc1a9a6efb'

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,AppRun,ferdi,' ferdi.desktop"
  end

  def self.build
    ferdi = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/ferdi
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
    File.write('ferdi.sh', ferdi)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ferdi"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'ferdi.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'ferdi.sh', "#{CREW_DEST_PREFIX}/bin/ferdi", mode: 0o755
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/ferdi"
  end

  def self.postinstall
    puts "\nType 'ferdi' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.config/autostart"
    if Dir.exist? config_dir
      print "Would you like to remove the config directory #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
