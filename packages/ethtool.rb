# Adapted from Arch Linux ethtool PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ethtool/trunk/PKGBUILD

require 'buildsystems/autotools'

class Ethtool < Autotools
  description 'Utility for controlling network drivers and hardware'
  homepage 'https://www.kernel.org/pub/software/network/ethtool/'
  version '7.2'
  license 'LGPL2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/software/network/ethtool/ethtool-#{version}.tar.xz"
  source_sha256 '44256ddf4631ed08d816b7b8725f4b2e0f05e96b8c7ca64ee5c81449da2b6507'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50ddf3718c57e1abac0c43d03658474b557e24201b9741f568223d7fe4b2b826',
     armv7l: '50ddf3718c57e1abac0c43d03658474b557e24201b9741f568223d7fe4b2b826',
       i686: '149a4074fcdd3f5d1cd5ca363a34b4c7126026932b775b7d3f277504a208b75f',
     x86_64: '0b3cd4fe4fa8235cd2d23cd86da46c8c76f9edd5d11c2d3e9ff2ee9cb413b68e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libmnl' => :executable

  # Tests fail for arm builds.
  run_tests

  autotools_configure_options "--sbindir=#{CREW_PREFIX}/bin"
end
