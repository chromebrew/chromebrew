require 'package'

class Bluefish < Package
  description 'Bluefish is a powerful editor targeted towards programmers and webdevelopers'
  homepage 'http://bluefish.openoffice.nl/index.html'
  version '2.2.10'
  compatibility 'all'
  source_url 'https://www.bennewitz.com/bluefish/stable/source/bluefish-2.2.10.tar.bz2'
  source_sha256 'afeca12b693bb58e30c2199e6a21cc06da02d88e0ac9d08b7a231a9c8e7c3eb2'

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
