require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.24.9'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.9.tar.xz'
  source_sha256 '577eb0270d9adf2eb2aa4b03f9c7873fadb20cf265194d0139570f738493e635'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '45f35424d4861f51e2f5a0db47326917dd79dd0bdf2985416150c972b8e73afb',
     armv7l: '45f35424d4861f51e2f5a0db47326917dd79dd0bdf2985416150c972b8e73afb',
       i686: 'c1aea89a1dd4e99399fb14c876694930818826b40d004b51f6fdf5017a772d0e',
     x86_64: '733220ec0f0d4eb5d51c03b76d9c06564440a77ddc2ff3c63dca8ba2ed72380c',
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

  def self.build
    system './configure',
           '--with-x',
           '--enable-cups',
           '--disable-debug',
           '--enable-x11-backend',
           '--enable-introspection',
           '--disable-gtk-doc-html',
           "--prefix=#{CREW_PREFIX}",
           '--enable-wayland-backend',
           '--enable-broadway-backend',
           '--disable-maintainer-mode',
           "--libdir=#{CREW_LIB_PREFIX}",
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
