require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://gnu.org/s/gettext/'
  version "0.26"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  git_hashtag "v#{version.split('-')[0]}"
  source_url "https://ftpmirror.gnu.org/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'a0151088dad8942374dc038e461b228352581defd7055e79297f156268b8d508'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd78311d4896db474a7ca61476fb173f7b614bfc50107f3090e97d6f5c29227aa',
     armv7l: 'd78311d4896db474a7ca61476fb173f7b614bfc50107f3090e97d6f5c29227aa',
       i686: '04a7d7871ba482f43cc46375f5ed2683d33c33538b64932ebb6076969c27564d',
     x86_64: 'a16897bb38461517b9fe8faf0e895e604f998f17efd364ddbf44c11707bd2dd4'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'wget2' => :build

  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'
end
