require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.22.3-1'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.3.tar.lz'
  source_sha256 '109da96c68c3df67ef6dadac23fe9f4e9ba3dc07a9844cb10b08a612cb9e6f71'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3-1_armv7l/gettext-0.22.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3-1_armv7l/gettext-0.22.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3-1_i686/gettext-0.22.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22.3-1_x86_64/gettext-0.22.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '24a0761b11edfac50d17685cf89aceac88cc33fe7f12727be22ecc857a16e610',
     armv7l: '24a0761b11edfac50d17685cf89aceac88cc33fe7f12727be22ecc857a16e610',
       i686: 'd580f9bf40e653f6fd15263a32a80307b0b015b8318c11c964a3e0f0cdea6322',
     x86_64: 'c95075168a6c0155f6d139d0f05662b962ffc399bcd0538ca1bf31cae7e7acc6'
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
