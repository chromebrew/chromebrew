require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version "0.25-#{CREW_ICU_VER}-1"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/pub/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'aa78157d5c9e042c01955091dccf7d7abd4f9463a885b0dbcc70725181ab5244'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76e4ea0e82bc7465e1d822e76ca46844b1d43d867b4803b7113d38b1a6d8de18',
     armv7l: '76e4ea0e82bc7465e1d822e76ca46844b1d43d867b4803b7113d38b1a6d8de18',
       i686: 'c1d0965ea6c5e78f0a314a44def43351e5c94279d25cfd46733617185bb79aa2',
     x86_64: 'c016e20248d296f40fa6a6eee0986e760be047bd71fa89f80167ace2b13f4aff'
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
