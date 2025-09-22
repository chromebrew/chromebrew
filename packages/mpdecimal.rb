# Adapted from Arch Linux mpdecimal PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/mpdecimal/trunk/PKGBUILD

require 'buildsystems/autotools'

class Mpdecimal < Autotools
  description 'Package for correctly-rounded arbitrary precision decimal floating point arithmetic'
  homepage 'https://www.bytereef.org/mpdecimal/index.html'
  version '4.0.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-#{version}.tar.gz"
  source_sha256 '96d33abb4bb0070c7be0fed4246cd38416188325f820468214471938545b1ac8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00b9db4d97e95a6d08a5e4647cdec3c54cdaee4960f1535c169870a8b8a19a16',
     armv7l: '00b9db4d97e95a6d08a5e4647cdec3c54cdaee4960f1535c169870a8b8a19a16',
       i686: '9643dda5c75535755f02b127372eeef28f045f17f2489758128b4fa7ab9761fe',
     x86_64: 'e9b8b7699c8c1876f56033752b962165bc47d82b866ee9fbdfe31247a651b2d0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
