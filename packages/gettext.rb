require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.22.3'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.3.tar.lz'
  source_sha256 '109da96c68c3df67ef6dadac23fe9f4e9ba3dc07a9844cb10b08a612cb9e6f71'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3_armv7l/gettext-0.22.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3_armv7l/gettext-0.22.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3_i686/gettext-0.22.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3_x86_64/gettext-0.22.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd31ef5b9149219196b389e505d999b698bf124b88c850deb294e743607bc448f',
     armv7l: 'd31ef5b9149219196b389e505d999b698bf124b88c850deb294e743607bc448f',
       i686: '429bfd53a81afabf131c4150e5261929231541b39b31ef47c929674f57dd42fe',
     x86_64: 'c32933f4644304b0d793315876335663b6c5b6b9a850cfb74778186f3a8cd1b4'
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
end
