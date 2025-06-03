require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version "0.25-#{CREW_ICU_VER}-2"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/pub/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'aa78157d5c9e042c01955091dccf7d7abd4f9463a885b0dbcc70725181ab5244'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdcfd5f5bd723f260a703fb178bf28b84d37c9c2fbf29810c8203e443c580173',
     armv7l: 'fdcfd5f5bd723f260a703fb178bf28b84d37c9c2fbf29810c8203e443c580173',
       i686: '9718e89ce9c5281da103718d1ad3d074795f486a9b98b52a15dafe3d6c818abf',
     x86_64: '85779568de989da66eec6e2a80e5442006c30da2a783b9aa40e4dc339813c32c'
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
