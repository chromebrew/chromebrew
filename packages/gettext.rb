require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.22.5'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.5.tar.lz'
  source_sha256 'caa44aed29c9b4900f1a401d68f6599a328a3744569484dc95f62081e80ad6cb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3b5f9dc11b4158694bd2ff9b06464fe5218dceb99720248178030a51efbc08a',
     armv7l: 'c3b5f9dc11b4158694bd2ff9b06464fe5218dceb99720248178030a51efbc08a',
       i686: '5a6a375b91d4546ae573fc138cbf2a7f686552bca019ac0fa3c129dbec034795',
     x86_64: '4129d6eb6791bafb1695e749d4622dc9ae85d702d3473a48aacc47a803a8fa92'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'openjdk8' => :build
  depends_on 'zlibpkg' # R

  no_env_options

  configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'

  run_tests
end
