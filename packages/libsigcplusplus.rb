require 'package'

class Libsigcplusplus < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '3.6.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/releases/download/#{version}/libsigc++-#{version}.tar.xz"
  source_sha256 'c3d23b37dfd6e39f2e09f091b77b1541fbfa17c4f0b6bf5c89baef7229080e17'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9df135245919b3b163f39dd4d353dc99d2a8e22e3d375a53d7981eace04dc4bf',
     armv7l: '9df135245919b3b163f39dd4d353dc99d2a8e22e3d375a53d7981eace04dc4bf',
       i686: '580a74d447ca6ec8c54988d5489220da31bc4dd73df0d99443e05984a598b482',
     x86_64: 'c337859e30d47caf4a46fe7476c350a8f8a63449c9c5e5c2e3b2c2358d3deb53'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  no_upstream_update

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-deprecated-api=true \
    -Dbuild-examples=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
