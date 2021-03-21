require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '40.rc'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.rc/sources/adwaita-icon-theme-40.rc.tar.xz'
  source_sha256 'd794a492e8e7db33bdc19898effabc1f1205302e166da522c5351a8eba9da404'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f8cd7b689fb6debe871906165b0f0e93542db14b23b7f9f26fce30cbdec48246',
     armv7l: 'f8cd7b689fb6debe871906165b0f0e93542db14b23b7f9f26fce30cbdec48246',
       i686: 'b400562bbdbf9f0b97dfd259de529882c97548d726334d57f15e9876fdce28d4',
     x86_64: '91da1bc30615a25d9d239eb05e8782ca2a4efbffafe6da7693976dcb1cb2c6fa'
  })

  depends_on 'cantarell_fonts'
  depends_on 'gtk3'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  def self.build
    # Need to make sure svg support is properly loaded otherwise build fails.
    system "env GDK_PIXBUF_MODULEDIR='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders' \
    GDK_PIXBUF_MODULE_FILE='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache' \
    gdk-pixbuf-query-loaders > #{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
