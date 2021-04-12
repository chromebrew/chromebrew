require 'package'

class Gtksourceview_5 < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  @_ver = '5.0.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtksourceview/-/archive/#{@_ver}/gtksourceview-#{@_ver}.tar.bz2"
  source_sha256 'b97ee7f2404d00ba607b865a838ee7c90053811c16c633a6359dace4ee1f218c'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview_5-5.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview_5-5.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview_5-5.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview_5-5.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0e1f4e4d940074837e075f5008dd5178b5e9c6b4bcf2f8eabd16002adf7adb8c',
     armv7l: '0e1f4e4d940074837e075f5008dd5178b5e9c6b4bcf2f8eabd16002adf7adb8c',
       i686: 'd27b36e8275ba473c3758ae708eebd1aa80a34a346db5a44593d196f9f2f96a7',
     x86_64: '455fb554c60675f9c15b77510cab48ed1986caba9f7c9cabe6f6d945bb30962e'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'harfbuzz'
  depends_on 'libsoup'
  depends_on 'pango'
  depends_on 'vala'
  depends_on 'vulkan_icd_loader'

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto/g' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
