require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.16.0'
  compatibility 'all'
  source_url 'https://www.cairographics.org/releases/cairomm-1.16.0.tar.xz'
  source_sha256 '7e881492c5f9f546688c31160deb742c166fc4c68b6b8eb9920c00a0f0f144f9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.16.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c1d71ead86e471d5a7197385f9265c7c9b18cbe875bb1b44d21e8d7db455b42e',
     armv7l: 'c1d71ead86e471d5a7197385f9265c7c9b18cbe875bb1b44d21e8d7db455b42e',
       i686: 'ca252ba384eaa24a2cce9d3e8d05071b90f15bab7a714acd85af0b518c87495a',
     x86_64: '84355939a5c61018943d37073c9c364295598a205769d15bd9d7c5d820a50778'
  })

  depends_on 'cairo'
  depends_on 'libsigcplusplus3'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-examples=false \
    -Dbuild-tests=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
