# Adapted from Arch Linux ethtool PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ethtool/trunk/PKGBUILD

require 'buildsystems/autotools'

class Ethtool < Autotools
  description 'Utility for controlling network drivers and hardware'
  homepage 'https://www.kernel.org/pub/software/network/ethtool/'
  version '6.15'
  license 'LGPL2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/software/network/ethtool/ethtool-#{version}.tar.xz"
  source_sha256 '9477c365114d910120aaec5336a1d16196c833d8486f7c6da67bedef57880ade'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1af70078a68fc26cb6f95d8405e59a74c8986a1287205d01ff985d76a5835870',
     armv7l: '1af70078a68fc26cb6f95d8405e59a74c8986a1287205d01ff985d76a5835870',
       i686: 'dfd309329efc727a024894d5aaf89a37c891bd0713bfa1448eb3dcf2064b3185',
     x86_64: '851d246301bdbde1d68a33e1cddc6c09a69d4eef077f708947faf7e10d052136'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests

  autotools_configure_options "--sbindir=#{CREW_PREFIX}/bin"
end
