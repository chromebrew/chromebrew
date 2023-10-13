require 'package'

class Rlottie < Package
  description 'rlottie is a platform independent standalone c++ library for rendering vector based animations and art in realtime.'
  homepage 'https://github.com/Samsung/rlottie'
  version '0.2'
  license 'BSD, FTL, JSON and MIT'
  compatibility 'all'
  source_url "https://github.com/Samsung/rlottie/archive/v#{version}.tar.gz"
  source_sha256 '030ccbc270f144b4f3519fb3b86e20dd79fb48d5d55e57f950f12bab9b65216a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rlottie/0.2_armv7l/rlottie-0.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rlottie/0.2_armv7l/rlottie-0.2-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rlottie/0.2_i686/rlottie-0.2-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rlottie/0.2_x86_64/rlottie-0.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd41beeacb713a50355e002ce77a58344a9d4fca4d6dee45fce370657733e5088',
      armv7l: 'd41beeacb713a50355e002ce77a58344a9d4fca4d6dee45fce370657733e5088',
        i686: '64d0f691c23362e42c6a1c547ff44e1f0de100b4a6cb366fb744cf4bcc7dcbcc',
      x86_64: 'bd04ab18b3fa491ecb1358e9fabc980a266859c3d867d62a2d327649ee1d4d33'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
