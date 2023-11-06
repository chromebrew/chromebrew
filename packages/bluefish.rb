require 'package'

class Bluefish < Package
  description 'Bluefish is a powerful editor targeted towards programmers and webdevelopers'
  homepage 'http://bluefish.openoffice.nl/index.html'
  version '2.2.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.bennewitz.com/bluefish/stable/source/bluefish-2.2.13.tar.bz2'
  source_sha256 '9b56966209d50951326a2ae21c7fd692bd91661d047ad3a01c97ba731aa477fb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.13_armv7l/bluefish-2.2.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.13_armv7l/bluefish-2.2.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.13_i686/bluefish-2.2.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bluefish/2.2.13_x86_64/bluefish-2.2.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1994ac56d3a6ef304cf7078cadb49b56ff10205bcf927dc300d2256ad9a4e34a',
     armv7l: '1994ac56d3a6ef304cf7078cadb49b56ff10205bcf927dc300d2256ad9a4e34a',
       i686: 'da77b243489213b9e15d9c3500de3595293aba1b47620a4bc8951feb356fd082',
     x86_64: 'fb4d57255f3146e67c50f6f60e305d9781a804372b80c90c53539f2e12177b22'
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

  reload_source

  def self.build
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
    @bluefish = <<~EOF
      alias bluefish="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland #{CREW_PREFIX}/bin/bluefish"
    EOF
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-bluefish", @bluefish)
    # Remove conflicts with shared_mime_info files.
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/mime"
  end

  def self.postinstall
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end

  def self.remove
    config_dir = "#{HOME}/.bluefish"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all bluefish config!'.orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
