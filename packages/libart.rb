require 'buildsystems/autotools'

class Libart < Autotools
  description 'Libart is a library for high-performance 2D graphics.'
  homepage 'https://www.levien.com/libart/'
  version '2.3.21'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/Archive/libart_lgpl.git'
  git_hashtag "LIBART_LGPL_#{version.tr('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d5d790f92263ff6d4ab4810eaf626d0f21b87b5d89c5e660a83a3c2fda0fe42',
     armv7l: '2d5d790f92263ff6d4ab4810eaf626d0f21b87b5d89c5e660a83a3c2fda0fe42',
       i686: 'e23c5f1dcc99a849409ad7891d2d8f308ab2a99c007fb7bebeb1486a809825df',
     x86_64: '099330b9d00e067422fed9864539578563e1b9688922a31d543775e7e22cd7a2'
  })

  depends_on 'glibc' # R
  depends_on 'gnome_common' => :build
end
