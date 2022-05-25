# Adapted from Arch Linux exempi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/exempi/trunk/PKGBUILD

require 'buildsystems/autotools'

class Exempi < Autotools
  description 'A library to parse XMP metadata'
  homepage 'https://libopenraw.freedesktop.org/wiki/Exempi'
  version '2.6.4'
  license 'BSD'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/libopenraw/exempi/-/archive/#{version}/exempi-#{version}.tar.bz2"
  source_sha256 '8d34b3860192f6d2ac017537884b099b13a492ed4884130c65da5173d5162590'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.4_armv7l/exempi-2.6.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.4_armv7l/exempi-2.6.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.4_i686/exempi-2.6.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.4_x86_64/exempi-2.6.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f9ed9074c94cbf4bc9888698b3d953e5d1174c810c09701e336eaf0555449766',
     armv7l: 'f9ed9074c94cbf4bc9888698b3d953e5d1174c810c09701e336eaf0555449766',
       i686: '3a1b5f6f68ec1742e71a1113a9034b47d57255782e7e81a51287d23916fcb735',
     x86_64: 'e3651643073233be72ced1c0d4644ac7577d04b8fecd4d69be694af3adcdf950'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'boost' => :build
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R
end
