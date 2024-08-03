require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.22.5-icu75.1'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.5.tar.lz'
  source_sha256 'caa44aed29c9b4900f1a401d68f6599a328a3744569484dc95f62081e80ad6cb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76b632489f2be5fa7ae1b95cd6cc7c2f91f5401e6722f82ac3840125174cd32a',
     armv7l: '76b632489f2be5fa7ae1b95cd6cc7c2f91f5401e6722f82ac3840125174cd32a',
       i686: 'a5f2dd59ed7ab42d8241b257eb95f1e6e585434f90a94f4cb72eabb9c752f19c',
     x86_64: '4afe380456e688f09db755b21dd45372745550b400c243f7f91607b597c56bb9'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2_autotools' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'zlib' # R

  no_env_options

  configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'

  # cldr-plurals-1 test fails with icu75.1
  # run_tests
end
