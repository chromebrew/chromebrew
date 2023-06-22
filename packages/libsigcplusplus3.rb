require 'package'

class Libsigcplusplus3 < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '3.0.6'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/archive/#{version}.tar.gz"
  source_sha256 '25ff9bf59c28e185c3901963f11bbdac58ce866281c65c870145b119e59a0836'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.0.6_armv7l/libsigcplusplus3-3.0.6-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.0.6_armv7l/libsigcplusplus3-3.0.6-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.0.6_i686/libsigcplusplus3-3.0.6-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus3/3.0.6_x86_64/libsigcplusplus3-3.0.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '30e2d139bec3e807e96ebee3047ec91fb080def2c0d45ca27aa2ba383e8fb9d6',
      armv7l: '30e2d139bec3e807e96ebee3047ec91fb080def2c0d45ca27aa2ba383e8fb9d6',
        i686: '497f109d9d2c97bb13ce0df424cb8ec6eb7fa46e34b96e585b9831bb2d75f69c',
      x86_64: 'f5c843178b73298dc190a48f3dabdf5626121aeb436ba05b26a481160b909bb7'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-examples=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
