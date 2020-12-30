require 'package'

class Bluefish < Package
  description 'Bluefish is a powerful editor targeted towards programmers and webdevelopers'
  homepage 'http://bluefish.openoffice.nl/index.html'
  version '2.2.10'
  compatibility 'all'
  source_url 'https://www.bennewitz.com/bluefish/stable/source/bluefish-2.2.10.tar.bz2'
  source_sha256 'afeca12b693bb58e30c2199e6a21cc06da02d88e0ac9d08b7a231a9c8e7c3eb2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bluefish-2.2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea47d2b5ecded9b79975d1ea7f2df86e441e9ac85e4fc6c331f1fdf3869498ae',
     armv7l: 'ea47d2b5ecded9b79975d1ea7f2df86e441e9ac85e4fc6c331f1fdf3869498ae',
       i686: '405127fefd5539f779fe4810aa302371f5919ac1a02017686049a7cb7ab91759',
     x86_64: '7403531e5aef2c5d7afe05433fa4d6c3b5b74797a3b4e81ef4ebd20c32de228d',
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
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mv '#{CREW_DEST_PREFIX}/bin/bluefish', '#{CREW_DEST_PREFIX}/bin/bluefish_orig'
    system "cat <<'EOF'> bluefish
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/bluefish_orig $@
EOF"
    system "install -Dm755 bluefish #{CREW_DEST_PREFIX}/bin/bluefish"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
