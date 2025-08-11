require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://gnu.org/s/gettext/'
  version '0.26'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  git_hashtag "v#{version.split('-')[0]}"
  source_url "https://ftpmirror.gnu.org/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'a0151088dad8942374dc038e461b228352581defd7055e79297f156268b8d508'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b70f7d97866657b50e5d85c9f48d620b36730ee5f187684a73be7f812e03427e',
     armv7l: 'b70f7d97866657b50e5d85c9f48d620b36730ee5f187684a73be7f812e03427e',
       i686: 'f9af1063d68f3c0bb4c6ec8232d7eea24c586c4807babe12b62c0deaf5b099d1',
     x86_64: '10d1fadbfb2290846aa28e478efcc5dac4d132d9a0e4a9b563439e653fd794d4'
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
