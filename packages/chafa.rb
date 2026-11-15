require 'buildsystems/autotools'

class Chafa < Autotools
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.18.3'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/hpjansson/chafa.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '912da0358ebfb3cd3488961b0426c9ee8bc88d057d90a90fd09b72d4a5b97728',
     armv7l: '912da0358ebfb3cd3488961b0426c9ee8bc88d057d90a90fd09b72d4a5b97728',
     x86_64: '70dec4ba5817b2cb3a12991e93fb142ff8c6ab84d6167a8ad7771cdb74a5fc35'
  })

  depends_on 'cairo' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'librsvg' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libxslt' => :build

  autotools_configure_options '--enable-gtk-doc'
end
