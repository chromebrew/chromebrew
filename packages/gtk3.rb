require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.24.23'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.23.tar.xz'
  source_sha256 '5d864d248357a2251545b3387b35942de5f66e4c66013f0962eb5cb6f8dae2b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dcb34ab52e30687e837381fa223d0935d89622d380e8187b9de2db87d0cc49fd',
     armv7l: 'dcb34ab52e30687e837381fa223d0935d89622d380e8187b9de2db87d0cc49fd',
       i686: '2a835418e1553be488b2f3e9dddda16bb2e90cb5b1b77abead42f0b79bb73ec6',
     x86_64: '4db8850af34d796ad8460a96f1b5c079d52b8c085833f2b39ed31c688db1e964',
  })

  depends_on 'gdk_pixbuf'
  depends_on 'iso_codes'
  depends_on 'json_glib'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'
  depends_on 'gobject_introspection'
  depends_on 'cups'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build
  depends_on 'xdg_base'
  depends_on 'llvm' => :build

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
