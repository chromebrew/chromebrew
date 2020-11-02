require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '3.38.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/adwaita-icon-theme/3.38/adwaita-icon-theme-3.38.0.tar.xz'
  source_sha256 '6683a1aaf2430ccd9ea638dd4bfe1002bc92b412050c3dba20e480f979faaf97'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-3.38.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-3.38.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-3.38.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-3.38.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14e772b1659a40a0021bc31592c844109514a5193af60771bdde68619d401773',
     armv7l: '14e772b1659a40a0021bc31592c844109514a5193af60771bdde68619d401773',
       i686: '80b7ddd46eab62bb102415ce354e8931362a0757cf498c6eefc1d80bcf55cb63',
     x86_64: '049d7fdb6a435484ae5a2cca69b203dd6b8ee6bae088edb3a04c6de2c2c13ecf',
  })

  depends_on 'gtk3'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf' 
  depends_on 'vala' => :build
  depends_on 'llvm' => :build
  depends_on 'xdg_base'
  
  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    ENV['GDK_PIXBUF_MODULEDIR'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV['GDK_PIXBUF_MODULE_FILE'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    ENV['LIBRARY_PATH'] = "#{CREW_LIB_PREFIX}:/usr/#{ARCH_LIB}:/#{ARCH_LIB}"
    # Need to make sure svg support is properly loaded otherwise build fails.
    system "gdk-pixbuf-query-loaders > #{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    system "./configure #{CREW_OPTIONS} "
    system 'make'
  end
  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
  
    def self.postinstall
    puts "To add basic settings, execute the following:".lightblue
    puts "Note that this will overwrite any existing ~/.config/gtk-3.0/settings.ini file!".lightred
    puts
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
