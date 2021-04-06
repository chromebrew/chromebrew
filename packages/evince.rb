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
  depends_on 'at_spi2_atk'
  depends_on 'at_spi2_core'
  depends_on 'avahi'
  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'dbus'
  depends_on 'dconf'
  depends_on 'djvulibre'
  depends_on 'docbook_xsl' => ':build'
  depends_on 'elfutils'
  depends_on 'eudev'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'ghostscript'
  depends_on 'glib'
  depends_on 'gnome_desktop'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'graphite'
  depends_on 'gsfonts'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => ':build'
  depends_on 'harfbuzz'
  depends_on 'lcms'
  depends_on 'libarchive'
  depends_on 'libdeflate'
  depends_on 'libdrm'
  depends_on 'libepoxy'
  depends_on 'libgcrypt'
  depends_on 'libgxps'
  depends_on 'libhandy'
  depends_on 'libjpeg'
  depends_on 'libpaper'
  depends_on 'libpng'
  depends_on 'libsecret'
  depends_on 'libspectre'
  depends_on 'libtiff'
  depends_on 'libunwind'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'libxau'
  depends_on 'libxcb'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxi'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'
  depends_on 'libxrandr'
  depends_on 'libxrender'
  depends_on 'libxshmfence'
  depends_on 'libxxf86vm'
  depends_on 'mesa'
  depends_on 'nautilus'
  depends_on 'nspr'
  depends_on 'nss'
  depends_on 'openjpeg'
  depends_on 'orc'
  depends_on 'pango'
  depends_on 'pcre'
  depends_on 'pixman'
  depends_on 'poppler'
  depends_on 't1lib'
  depends_on 'texlive'
  depends_on 'util_linux'
  depends_on 'wayland'

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
