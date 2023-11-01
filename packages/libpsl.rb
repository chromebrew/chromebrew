require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  @_ver = '0.21.2'
  version @_ver.to_s
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/rockdaboot/libpsl/releases/download/#{@_ver}/libpsl-#{@_ver}.tar.lz"
  source_sha256 'aa3d706c452786d1345e094dae201cd36d81f03cf81d636d5cfc10d365907f17'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.2_armv7l/libpsl-0.21.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.2_armv7l/libpsl-0.21.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.2_i686/libpsl-0.21.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.2_x86_64/libpsl-0.21.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '81c52e6dc9a2d935016d0f1d65dde2e2fa122f55e79c3a4a9465698041c5fe63',
     armv7l: '81c52e6dc9a2d935016d0f1d65dde2e2fa122f55e79c3a4a9465698041c5fe63',
       i686: '3c9c931dc72bf5dac871eef9dda2a866087b42457d6bd7535f2c760f33f27128',
     x86_64: '2ee50e70cf121a7f46577e0494cbfe121eb13c23ae8bc308027e5315ec8b4ccb'
  })

  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R
end
