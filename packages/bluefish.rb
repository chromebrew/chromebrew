require 'package'

class Bluefish < Package
  description 'Bluefish is a powerful editor targeted towards programmers and webdevelopers'
  homepage 'http://bluefish.openoffice.nl/index.html'
  version '2.2.12-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.bennewitz.com/bluefish/stable/source/bluefish-2.2.12.tar.gz'
  source_sha256 '948fc2921f0a67a7ce811220093a3b3dfc8021a6e3005f549373cd3402ee0f26'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.12-1_armv7l/bluefish-2.2.12-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.12-1_armv7l/bluefish-2.2.12-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.12-1_i686/bluefish-2.2.12-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.12-1_x86_64/bluefish-2.2.12-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2fe751616748e0b95f5a6aca86c89f5c09a4da0464ba303e1aa3bc6f8f0b52d7',
     armv7l: '2fe751616748e0b95f5a6aca86c89f5c09a4da0464ba303e1aa3bc6f8f0b52d7',
       i686: 'e872f959d21359dfb4144a2845cf99aa980888b8b9791a69e9b302c43209ebf4',
     x86_64: '3a2e64b50d1030cabef7091356ec1a8d7c0b8e1655666ca1d36d59a493c9ae7b'
  })

  depends_on 'enchant'
  depends_on 'gtk3'
  depends_on 'gnome_icon_theme'
  depends_on 'gucharmap'
  depends_on 'hicolor_icon_theme'
  depends_on 'hunspell'
  depends_on 'python3'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    bluefish = <<~EOF
      alias bluefish="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland #{CREW_PREFIX}/bin/bluefish"
    EOF
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-bluefish", bluefish)
    # Remove conflicts with shared_mime_info files.
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/mime"
  end

  def self.postinstall
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    puts "\nTo complete the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.bluefish"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all bluefish config!'.orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when '', 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
