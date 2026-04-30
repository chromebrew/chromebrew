require 'buildsystems/autotools'

class Chafa < Autotools
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.18.2'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/hpjansson/chafa.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91eb0c4c5e0ca7d9c618dbb386f8122fc2bb56dcb5c137f1d267951f47a21632',
     armv7l: '91eb0c4c5e0ca7d9c618dbb386f8122fc2bb56dcb5c137f1d267951f47a21632',
     x86_64: 'cd015e9ee7cb4f2e9c496b04f0623a492a89b2e4b6fb43cea483fd16366ae8f5'
  })

  depends_on 'cairo' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'librsvg' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libxslt' => :build

  autotools_configure_options '--enable-gtk-doc'
end
