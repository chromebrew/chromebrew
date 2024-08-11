require 'buildsystems/autotools'

class Librsvg < Autotools
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.58.2-icu75.1'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59dafc0bb05dafb25e81da2aad87b9f37f4da703503fac40efdcc4667937f018',
     armv7l: '59dafc0bb05dafb25e81da2aad87b9f37f4da703503fac40efdcc4667937f018',
     x86_64: '8c5e7dcf693001a1241f7abf629014d17afa4cbbe816ff1af292e958bf349000'
  })

  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libcroco' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libpng' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_six' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'rust' => :build
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  gnome

  configure_options '--enable-introspection=yes \
      --enable-vala=yes \
      --enable-pixbuf-loader'
end
