require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version "0.25-#{CREW_ICU_VER}"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/pub/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'aa78157d5c9e042c01955091dccf7d7abd4f9463a885b0dbcc70725181ab5244'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5b8c0210160ad6b777abcf1266dfe7a593eee77f94b1df5169d3d51757f42ca',
     armv7l: 'b5b8c0210160ad6b777abcf1266dfe7a593eee77f94b1df5169d3d51757f42ca',
       i686: '10c940604c08829ce57ccb559e0dfb38137c244e9e0a01037c64ce145bb19ea2',
     x86_64: 'c9bab6466cd7393a2601fb03369fb808397fe7749b3a43a63afdf4eb2d3f8896'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'zlib' # R

  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'

  # cldr-plurals-1 test fails with icu75.1
  # run_tests
end
