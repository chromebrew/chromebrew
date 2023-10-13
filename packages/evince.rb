# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'package'

class Evince < Package
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '44.rc'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/44.rc_armv7l/evince-44.rc-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/44.rc_armv7l/evince-44.rc-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evince/44.rc_x86_64/evince-44.rc-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a7817e8a1cea35f9c82bbf282cfe108354161ec37a709d03007bae083dbebd61',
     armv7l: 'a7817e8a1cea35f9c82bbf282cfe108354161ec37a709d03007bae083dbebd61',
     x86_64: 'a790320dfaf80b7b55caf2aad5f2fc757d59abe379776ec7f771e8fd7c85b298'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'djvulibre' # R
  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libarchive' # R
  depends_on 'libgxps' # R
  depends_on 'libhandy' # R
  depends_on 'libsecret' # R
  depends_on 'libspectre' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'nautilus' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dgtk_doc=false \
      -Dnautilus=false \
      -Dps=enabled \
      -Dsystemduserunitdir=no \
      builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
