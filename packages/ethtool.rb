# Adapted from Arch Linux ethtool PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ethtool/trunk/PKGBUILD

require 'buildsystems/autotools'

class Ethtool < Autotools
  description 'Utility for controlling network drivers and hardware'
  homepage 'https://www.kernel.org/pub/software/network/ethtool/'
  version '6.11'
  license 'LGPL2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/software/network/ethtool/ethtool-#{version}.tar.xz"
  source_sha256 'bb13db91915cacd7a492b65b65df07a67e4b974ddbeaf76205b1945a23d27686'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9492106c66a1714d5b31667e94dddfca01ba1146d69b5c02e190a5177b0d7b5a',
     armv7l: '9492106c66a1714d5b31667e94dddfca01ba1146d69b5c02e190a5177b0d7b5a',
       i686: '00c81b527fba805c379f63af5b0dbdffb348390b33549161819020419c646a7e',
     x86_64: 'ae240873dea05ff4cc6112844c1a2c1ff6bb0003de062b1fa9dfa1e5b1c89ef9'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests

  autotools_configure_options "--sbindir=#{CREW_PREFIX}/bin"
end
