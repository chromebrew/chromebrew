require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.22.4'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.4.tar.lz'
  source_sha256 'd2392ba0ad01961cff992da97f4b69fa5fe06bc20e33b5556c34d8aafde9cbe4'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.4_armv7l/gettext-0.22.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.4_armv7l/gettext-0.22.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.4_i686/gettext-0.22.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.4_x86_64/gettext-0.22.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8e48a950fc3f50244a83fb5af58b9c871dfa06bff1f02ce5835a28df2aa5bd7b',
     armv7l: '8e48a950fc3f50244a83fb5af58b9c871dfa06bff1f02ce5835a28df2aa5bd7b',
       i686: '83846c8469cba4e101a3e1c4480b2f1fb82c79f97097db9d7c3a62666a16b6c2',
     x86_64: '0f5284e735142a517c6cdcbcd94cb1963b17044aee865c3e14d4b498968ce3fb'
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
