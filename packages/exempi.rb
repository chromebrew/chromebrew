# Adapted from Arch Linux exempi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/exempi/trunk/PKGBUILD

require 'buildsystems/autotools'

class Exempi < Autotools
  description 'A library to parse XMP metadata'
  homepage 'https://libopenraw.freedesktop.org/wiki/Exempi'
  version '2.6.6'
  license 'BSD'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/libopenraw/exempi/-/archive/#{version}/exempi-#{version}.tar.bz2"
  source_sha256 'c553fe596d4e5b44ce645a3d9a8b1d8609f2572d50953b10fe7103380462e084'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91378cfb659b7e2274d67819ece09559741d0c54c7759bc041575f132dbf3cfd',
     armv7l: '91378cfb659b7e2274d67819ece09559741d0c54c7759bc041575f132dbf3cfd',
       i686: '98df788ee6bbe75d1440c1537d7bf3155982d5060f31619dbae40dac0085d433',
     x86_64: '9ec94e0eadb49908bed87211caa897d565d7967946c225a3f38214187fc042da'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'boost' => :build
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R
end
