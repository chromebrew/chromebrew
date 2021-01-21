require 'package'

class Bluefish < Package
  description 'Bluefish is a powerful editor targeted towards programmers and webdevelopers'
  homepage 'http://bluefish.openoffice.nl/index.html'
  version '2.2.12'
  compatibility 'all'
  source_url 'https://www.bennewitz.com/bluefish/stable/source/bluefish-2.2.12.tar.gz'
  source_sha256 '948fc2921f0a67a7ce811220093a3b3dfc8021a6e3005f549373cd3402ee0f26'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6e769339832399c45018d072a2c906c00025b16c1b4a3acd8c5ea58dafa86b3c',
     armv7l: '6e769339832399c45018d072a2c906c00025b16c1b4a3acd8c5ea58dafa86b3c',
       i686: '7f706a40177c68674b55fe19f25dbe91100fb08525b0fbe69767137e7db247ff',
     x86_64: '5ecc4aae82c14977ac46419fedbe4f298ca9e4e979d9ccca3c641dd6b298721c',
  })

  depends_on 'enchant'
  depends_on 'gtk3'
  depends_on 'gnome_icon_theme'
  depends_on 'gucharmap'
  depends_on 'hicolor_icon_theme'
  depends_on 'python3'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts "echo 'alias bluefish=\"WAYLAND_DISPLAY=wayland-0 DISPLAY=\'\' GDK_BACKEND=wayland bluefish\"' >> ~/.bashrc".lightblue
    puts
  end
end
