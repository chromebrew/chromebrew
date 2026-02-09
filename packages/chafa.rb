require 'buildsystems/autotools'

class Chafa < Autotools
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.18.1'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/hpjansson/chafa.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6d9dc18294c7c2a00d888cf4eedf1c3a415625625c60ef32e50d09f046aacfe',
     armv7l: 'f6d9dc18294c7c2a00d888cf4eedf1c3a415625625c60ef32e50d09f046aacfe',
     x86_64: 'bb460334e3a93e55c323b9d3269558b1c62071291950b2a924e4ef6d5764ec3c'
  })

  depends_on 'cairo' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'librsvg' # R
  depends_on 'libtiff' # R
  depends_on 'libxslt' # R

  autotools_configure_options '--enable-gtk-doc'
end
