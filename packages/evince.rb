# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'buildsystems/meson'

class Evince < Meson
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '45.0'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7817e8a1cea35f9c82bbf282cfe108354161ec37a709d03007bae083dbebd61',
     armv7l: 'a7817e8a1cea35f9c82bbf282cfe108354161ec37a709d03007bae083dbebd61',
     x86_64: 'a790320dfaf80b7b55caf2aad5f2fc757d59abe379776ec7f771e8fd7c85b298'
  })

  depends_on 'at_spi2_core' => :build
  depends_on 'cairo' => :build
  depends_on 'djvulibre' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glibc' => :build
  depends_on 'glib' => :build
  depends_on 'gnome_desktop' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'libarchive' => :build
  depends_on 'libgxps' => :build
  depends_on 'libhandy' => :build
  depends_on 'libsecret' => :build
  depends_on 'libspectre' => :build
  depends_on 'libtiff' => :build
  depends_on 'libxml2' => :build
  depends_on 'nautilus' => :build
  depends_on 'pango' => :build
  depends_on 'poppler' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' => :build

  gnome

  meson_options '-Dgtk_doc=false \
      -Dnautilus=false \
      -Dps=enabled \
      -Dsystemduserunitdir=no'
end
