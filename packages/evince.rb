# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'package'

class Evince < Package
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '40.2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.2_armv7l/evince-40.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.2_armv7l/evince-40.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.2_i686/evince-40.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.2_x86_64/evince-40.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '74251f49f4fe22b9a19e4cbd16770d270eb13147df23265e62bb960ec71634e0',
     armv7l: '74251f49f4fe22b9a19e4cbd16770d270eb13147df23265e62bb960ec71634e0',
       i686: '30051f33d1c73422b28298ccb9f7a84cc6dbb30a742cc01aef63d7054b090b04',
     x86_64: '49e164c40f852960136be7660fc38be92d6517d45c073d2b076dcdbf643cffd6'
  })

  depends_on 'atk' # R
  depends_on 'cairo' # R
  depends_on 'djvulibre' # R
  depends_on 'docbook_xsl' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gst_plugins_base' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libgxps' # R
  depends_on 'libhandy' # R
  depends_on 'libsecret' # R
  depends_on 'libspectre' # R
  depends_on 'libtiff' # R
  depends_on 'nautilus' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'valgrind' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
