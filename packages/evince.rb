# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'package'

class Evince < Package
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '40.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.1_armv7l/evince-40.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.1_armv7l/evince-40.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.1_i686/evince-40.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/40.1_x86_64/evince-40.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '62b72ae5cb06f66f219254ca9538c1cb28f91d869689f70f1551d89d5acbd336',
     armv7l: '62b72ae5cb06f66f219254ca9538c1cb28f91d869689f70f1551d89d5acbd336',
       i686: '35fddcde12a82b65876ef8ddc6f4dee8b42f74b1c746a5f51a84e2b686bcce8b',
     x86_64: '66c5249315ae4e4f348ea5c2d732323623f8eb834ffc7cd353a53de966a7672a'
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
