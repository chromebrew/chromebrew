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
    aarch64: '75ba671255aa82733e1cd6e48828d1c1438d9505478066b312196c2c1b140369',
     armv7l: '75ba671255aa82733e1cd6e48828d1c1438d9505478066b312196c2c1b140369',
       i686: 'eac15d7439592c7c165333c19dc6268b76cd4800b810a8a2395991cbae3686ed',
     x86_64: 'ee5bed2bab217c458efe10fb8a4697034e0c6a787880e5f7b7f8e79649f5b0bb'
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
