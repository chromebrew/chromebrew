require 'buildsystems/meson'

class Iputils < Meson
  description 'A set of small useful utilities for Linux networking.'
  homepage 'https://github.com/iputils/iputils'
  version '20221126'
  license 'GPL-2, BSD-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/iputils/iputils/archive/refs/tags/20221126.tar.gz'
  source_sha256 '745ea711fe06d5c57d470d21acce3c3ab866eb6afb69379a16c6d60b89bd4311'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iputils/20221126_armv7l/iputils-20221126-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iputils/20221126_armv7l/iputils-20221126-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iputils/20221126_x86_64/iputils-20221126-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd93ed9cbd3a46ecb6c11cd00f57d7fa752b1b795834ff6a1c661a3378f3e2319',
     armv7l: 'd93ed9cbd3a46ecb6c11cd00f57d7fa752b1b795834ff6a1c661a3378f3e2319',
     x86_64: 'd1121876b22ad730e6bad1d4caca60b14da247990f27202d5a7120eba38d5efc'
  })

  depends_on 'glibc' # R
  depends_on 'libcap' # R
  depends_on 'libidn2' # R
  depends_on 'gcc_lib' # R

  meson_options '-DSKIP_TESTS=true'
end
