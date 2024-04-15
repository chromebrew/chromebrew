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
    aarch64: '25eb43693a5ca3fc77814f63d91a5dd07382f9e73f4bd10d689751485395519d',
     armv7l: '25eb43693a5ca3fc77814f63d91a5dd07382f9e73f4bd10d689751485395519d',
     x86_64: 'b18d1011d5dcf0718034146d0f93ede644b15111e005167391c7c52e057d5288'
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
  depends_on 'nautilus' => :build
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R

  gnome

  meson_options '-Dgtk_doc=false \
      -Dintrospection=false \
      -Dnautilus=false \
      -Dps=enabled \
      -Dsystemduserunitdir=no'
end
