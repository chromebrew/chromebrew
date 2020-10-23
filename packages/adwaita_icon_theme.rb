require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '3.38.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/adwaita-icon-theme/3.38/adwaita-icon-theme-3.38.0.tar.xz'
  source_sha256 '6683a1aaf2430ccd9ea638dd4bfe1002bc92b412050c3dba20e480f979faaf97'

  depends_on 'gtk3'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf' 
  depends_on 'vala' => :build
  
  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    ENV['GDK_PIXBUF_MODULEDIR'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV['GDK_PIXBUF_MODULE_FILE'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    ENV['LIBRARY_PATH'] = "#{CREW_LIB_PREFIX}:/usr/$ARCH_LIB:/$ARCH_LIB:/usr/lib:/lib"
    # Need to make sure svg support is properly loaded otherwise build fails.
    system "LD_LIBRARY_PATH=#{CREW_LIB_PREFIX}:/usr/#{ARCH_LIB}:/#{ARCH_LIB}:/usr/lib:/lib #{CREW_PREFIX}/sbin/ldconfig"
    system "gdk-pixbuf-query-loaders > #{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    system "./configure #{CREW_OPTIONS} "
    system 'make'
  end
  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
  
    def self.postinstall
    puts "To add basic settings, execute the following:".lightblue
    puts "mkdir #{HOME}/.config/gtk-3.0".lightblue
    puts "cat << 'EOF' > #{HOME}/.config/gtk-3.0/settings.ini
[Settings]
gtk-application-prefer-dark-theme = false
gtk-icon-theme-name = adwaita
gtk-fallback-icon-theme = gnome
gtk-font-name = Arial 10
EOF".lightblue
    puts
  end
end
