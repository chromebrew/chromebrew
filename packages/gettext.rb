require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version "0.22.5-#{CREW_ICU_VER}"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.5.tar.lz'
  source_sha256 'caa44aed29c9b4900f1a401d68f6599a328a3744569484dc95f62081e80ad6cb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0528c0d1398c393ead61741a1fd473821275a61ad75e39c8130bd4db6b170a29',
     armv7l: '0528c0d1398c393ead61741a1fd473821275a61ad75e39c8130bd4db6b170a29',
       i686: '40f499bae4e3540779f998323178f72ff4f32cf4006a99518cb88c4d948f7069',
     x86_64: 'f8440ef3e6522ed8649a8aff0646d612a5b97908842b6c570c8795ba7ca2337c'
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

  no_env_options

  configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'

  # cldr-plurals-1 test fails with icu75.1
  # run_tests
end
