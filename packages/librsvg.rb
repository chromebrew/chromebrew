require 'buildsystems/autotools'

class Librsvg < Autotools
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.57.2'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e6aac5bc990a85aa112c6843c9c6b486b2d8386aebbaeb1a5ba4bf193cc83f4',
     armv7l: '7e6aac5bc990a85aa112c6843c9c6b486b2d8386aebbaeb1a5ba4bf193cc83f4',
     x86_64: 'a8ebeac12cc8d9c5f37b239b0ebb56e584f4589d341814fb35ad6eab232767a0'
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
  depends_on 'libjpeg' => :build
  depends_on 'libpng' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_six' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'rust' => :build
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  gnome

  configure_options '--enable-introspection=yes \
      --enable-vala=yes \
      --enable-pixbuf-loader'
end
