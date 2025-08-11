require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://gnu.org/s/gettext/'
  version "0.26-#{CREW_ICU_VER}"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  git_hashtag "v#{version.split('-')[0]}"
  source_url "https://ftpmirror.gnu.org/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'a0151088dad8942374dc038e461b228352581defd7055e79297f156268b8d508'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8aa6334e7ea9c03fe67cb3ae9b86fbafe37077dfee56dacc2d6437f068162cc',
     armv7l: 'd8aa6334e7ea9c03fe67cb3ae9b86fbafe37077dfee56dacc2d6437f068162cc',
       i686: '778749c7b70313f8563d2306b3d2bf3d80dbee5a7842bc87e8de1e4e3e86dc98',
     x86_64: '16abb691122eff1bcd6c96f470ebb2dcadc67f85990bc8c18651b901090cb9e5'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'wget2' => :build
  depends_on 'zlib' # R

  # git_fetchtags

  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'
end
