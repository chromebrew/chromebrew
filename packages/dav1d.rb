require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  @_ver = '0.9.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url "https://get.videolan.org/dav1d/#{@_ver}/dav1d-#{@_ver}.tar.xz"
  source_sha256 'cfae88e8067c9b2e5b96d95a7a00155c353376fe9b992a96b4336e0eab19f9f6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/0.9.0_armv7l/dav1d-0.9.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/0.9.0_armv7l/dav1d-0.9.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/0.9.0_i686/dav1d-0.9.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/0.9.0_x86_64/dav1d-0.9.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '54fa3dba94781b03e2e8c59ac24f29b3d085490a36a8cc18e438febd18509c24',
     armv7l: '54fa3dba94781b03e2e8c59ac24f29b3d085490a36a8cc18e438febd18509c24',
       i686: '72577ec0e01a901a1c8d1f7c0d8b673f556a3bed9d70570755ebe9b726659ec2',
     x86_64: '3f3f2a3756402e37bbde7d5d9f6374d2e183f2d9ce6ca49288718dc6a3746cb3'
  })

  depends_on 'nasm' => :build

  def self.build
    system "env CC=clang CXX=clang++ C_LD=lld CC_LD=lld \
      meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
