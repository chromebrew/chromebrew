# Adapted from Arch Linux evince PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/evince/trunk/PKGBUILD

require 'buildsystems/meson'

class Evince < Meson
  description 'Document viewer PDF, PostScript, XPS, djvu, dvi, tiff, cbr, cbz, cb7, cbt'
  homepage 'https://wiki.gnome.org/Apps/Evince'
  version '48.4'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/evince.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '233e5205df5aa2ae3514847633815b8c747e6d1808121a1f01ee24cda256a8bd',
     armv7l: '233e5205df5aa2ae3514847633815b8c747e6d1808121a1f01ee24cda256a8bd',
     x86_64: 'a9e1fe4faea05591a79687ff2d211736ded1a2378ad8195ac3119d543ebea013'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' => :build
  depends_on 'djvulibre' => :library
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnome_desktop' => :build
  depends_on 'gspell' => :library
  depends_on 'gstreamer' => :library
  depends_on 'gtk3' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'libarchive' => :library
  depends_on 'libgxps' => :build
  depends_on 'libhandy' => :executable
  depends_on 'libsecret' => :executable
  depends_on 'libspectre' => :library
  depends_on 'libtiff' => :library
  depends_on 'libxml2' => :library
  depends_on 'nautilus' => :build
  depends_on 'pango' => :library
  depends_on 'poppler' => :library
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' => :library

  gnome

  meson_options '-Dgtk_doc=false \
      -Dintrospection=false \
      -Dnautilus=false \
      -Dps=enabled \
      -Dsystemduserunitdir=no'
end
