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
    aarch64: 'ded7bc75870dca4c022bb97fc99a2da72f54833d3ab077f44bce5ea551de72dc',
     armv7l: 'ded7bc75870dca4c022bb97fc99a2da72f54833d3ab077f44bce5ea551de72dc',
       i686: '00c81b527fba805c379f63af5b0dbdffb348390b33549161819020419c646a7e',
     x86_64: 'b32262fb8c150d67098b274a7181288caf07dcbcac508307125ba4bff8926b81'
  })

  depends_on 'libmnl'
  depends_on 'glibc' # R

  run_tests

  configure_options "--sbindir=#{CREW_PREFIX}/bin"
end
