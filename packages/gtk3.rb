require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.24.23-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.23.tar.xz'
  source_sha256 '5d864d248357a2251545b3387b35942de5f66e4c66013f0962eb5cb6f8dae2b1'

  depends_on 'cups'
  depends_on 'at_spi2_atk'
  depends_on 'gcc10' => :build
  depends_on 'gnome_icon_theme'
  depends_on 'gobject_introspection'
  depends_on 'gdk_pixbuf'
  depends_on 'graphene'
  depends_on 'hicolor_icon_theme'
  depends_on 'iso_codes'
  depends_on 'json_glib'
  depends_on 'libepoxy'
  depends_on 'libxkbcommon'
  depends_on 'llvm' => :build
  depends_on 'shared_mime_info'
  depends_on 'six' => :build
  depends_on 'xdg_base'


  def self.build
    # The lld linker allows linking against system ChromeOS libs.
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system './configure',
           #{CREW_OPTIONS},
           '--with-x',
           '--enable-cups',
           '--disable-debug',
           '--enable-x11-backend',
           '--enable-introspection',
           '--disable-gtk-doc-html',
           '--enable-wayland-backend',
           '--enable-broadway-backend',
           '--disable-maintainer-mode',
           "--with-xml-catalog=#{CREW_PREFIX}/etc/xml/catalog"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    puts
    puts "To add basic settings, execute the following:".lightblue
    puts "mkdir #{HOME}/.config/gtk-3.0".lightblue
    puts "cat << 'EOF' > #{HOME}/.config/gtk-3.0/settings.ini
[Settings]
gtk-application-prefer-dark-theme = false
gtk-icon-theme-name = hicolor
gtk-fallback-icon-theme = gnome
gtk-font-name = Arial 10
EOF".lightblue
    puts
  end
end
