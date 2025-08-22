require 'package'

class Libsigcplusplus3 < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '3.6.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/releases/download/#{version}/libsigc++-#{version}.tar.xz"
  source_sha256 'c3d23b37dfd6e39f2e09f091b77b1541fbfa17c4f0b6bf5c89baef7229080e17'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93885ea1f4a7518db170d4ff91a4255d39331166d9a8a86660e72e2e8e507ea3',
     armv7l: '93885ea1f4a7518db170d4ff91a4255d39331166d9a8a86660e72e2e8e507ea3',
       i686: '539cdc9700f3fd686c2330b5d041d1b42bdd6ff9305d2ea5b522e592873ca016',
     x86_64: 'c61f3fd8ab4b2a9c2836071717f1834f69cc318c030fe6a47d4ff95a03c865c4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  no_upstream_update

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-examples=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
