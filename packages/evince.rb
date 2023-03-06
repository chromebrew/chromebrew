# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'package'

class Evince < Package
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '43.0'
  license 'GPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/43.0_armv7l/evince-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/43.0_armv7l/evince-43.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/43.0_i686/evince-43.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/43.0_x86_64/evince-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7a9a9a562931d0df03ae78badadb3e87a34c6810cbc848066bfae27d33695587',
     armv7l: '7a9a9a562931d0df03ae78badadb3e87a34c6810cbc848066bfae27d33695587',
       i686: '951637e6b83cf9682b7779d5394e403df80d3e9e291458ff8cd08589c9f4e104',
     x86_64: 'dc46b37780ac1b9f5c400a3bd8b4c8f01a0752b287747ced776e62b7be053cf5'
  })

  depends_on 'atk_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'djvulibre' # R
  depends_on 'docbook_xsl' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
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
  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dgtk_doc=false \
      -Dnautilus=false \
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
