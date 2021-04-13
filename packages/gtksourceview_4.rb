require 'package'

class Gtksourceview_4 < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  @_ver = '4.8.1'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtksourceview/-/archive/#{@_ver}/gtksourceview-#{@_ver}.tar.bz2"
  source_sha256 'ec16a6a61d643e278d3a02828257a59d802d4ae740247bf03fdebf10d9401635'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gtksourceview_4-4.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gtksourceview_4-4.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gtksourceview_4-4.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gtksourceview_4-4.8.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b6e5a158eaf5853eadcc5fcf3057c84b60800113358e3db76b1c9b716faec11e',
     armv7l: 'b6e5a158eaf5853eadcc5fcf3057c84b60800113358e3db76b1c9b716faec11e',
       i686: 'c0799e84f28569699b968f501a45f37e21b38ee0257774e87075139e54308094',
     x86_64: '68b3cea57e7cd0edf6712b9ad3b8c9c1e3b2b7723d7a1cc070178b04db597d82'
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
