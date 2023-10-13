require 'package'

class Libsigcplusplus < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '2.12.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/releases/download/#{version}/libsigc++-#{version}.tar.xz"
  source_sha256 '1c466d2e64b34f9b118976eb21b138c37ed124d0f61497df2a90ce6c3d9fa3b5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.12.0_armv7l/libsigcplusplus-2.12.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.12.0_armv7l/libsigcplusplus-2.12.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.12.0_i686/libsigcplusplus-2.12.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigcplusplus/2.12.0_x86_64/libsigcplusplus-2.12.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '75ba671255aa82733e1cd6e48828d1c1438d9505478066b312196c2c1b140369',
     armv7l: '75ba671255aa82733e1cd6e48828d1c1438d9505478066b312196c2c1b140369',
       i686: 'eac15d7439592c7c165333c19dc6268b76cd4800b810a8a2395991cbae3686ed',
     x86_64: 'ee5bed2bab217c458efe10fb8a4697034e0c6a787880e5f7b7f8e79649f5b0bb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

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
