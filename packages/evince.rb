# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'buildsystems/meson'

class Evince < Meson
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '48.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74d656129feb4be560d3f0796238c9436f610f63fd2df7b78422cae392cd88d7',
     armv7l: '74d656129feb4be560d3f0796238c9436f610f63fd2df7b78422cae392cd88d7',
     x86_64: '305b088604804d6e8da83e1f8936610199aab024a8de87d39ada08f59b9026e6'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'djvulibre' # R
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gspell' # R
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
  depends_on 'zlib' # R

  gnome

  meson_options '-Dgtk_doc=false \
      -Dintrospection=false \
      -Dnautilus=false \
      -Dps=enabled \
      -Dsystemduserunitdir=no'
end
