# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'package'

class Evince < Package
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '40.1'
  license 'GPL'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/evince/-/archive/#{version}/evince-#{version}.tar.bz2"
  source_sha256 '1c438051423334a49311c941f44924195c4823f64c2fcc55285eb529ef9bff06'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/evince-40.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/evince-40.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/evince-40.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/evince-40.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ff53c6f065e9d3efe0db2528ced3cf03124201fbe072ad3e113ee4dcc348c1d3',
     armv7l: 'ff53c6f065e9d3efe0db2528ced3cf03124201fbe072ad3e113ee4dcc348c1d3',
       i686: 'b3fa8f819fae5d173de436bf2ca2886763e04777c5a05fe81ce27a6e7e98dd57',
     x86_64: 'e9a5508adad335debaef3105f753fb3e2b821d554edcd8fcecf2da8c5a9bf5c5'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'djvulibre'
  depends_on 'docbook_xsl' => ':build'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gnome_desktop'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => ':build'
  depends_on 'libarchive'
  depends_on 'libgxps'
  depends_on 'libhandy'
  depends_on 'libsecret'
  depends_on 'libspectre'
  depends_on 'libtiff'
  depends_on 'nautilus'
  depends_on 'pango'
  depends_on 'poppler'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dgtk_doc=false \
      -Dps=enabled \
      -Dsystemduserunitdir=no \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
  end
end
