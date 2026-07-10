# Adapted from Arch Linux ethtool PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ethtool/trunk/PKGBUILD

require 'buildsystems/autotools'

class Ethtool < Autotools
  description 'Utility for controlling network drivers and hardware'
  homepage 'https://www.kernel.org/pub/software/network/ethtool/'
  version '7.1'
  license 'LGPL2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/software/network/ethtool/ethtool-#{version}.tar.xz"
  source_sha256 '4d78c26edc0255bc92f4b995b5fd66108d75ff966ed4694f6025a6d370bc2496'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1e52a4a6e83943d9975c29950a7003e747c487f46848d8e96276636a13674c8',
     armv7l: 'd1e52a4a6e83943d9975c29950a7003e747c487f46848d8e96276636a13674c8',
       i686: '3d6e7fc0d2d69650a24633e64f1bbc7817938fcfc1869426e637cad71bff227a',
     x86_64: 'd2cc764f30e1794c81c9bb71de164bf8a6b1442211d34580637c2d003d8f190d'
  })

  depends_on 'glibc' => :executable
  depends_on 'libmnl' => :executable

  # Tests fail for arm builds.
  run_tests

  autotools_configure_options "--sbindir=#{CREW_PREFIX}/bin"
end
