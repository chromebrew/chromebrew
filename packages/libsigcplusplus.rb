require 'package'

class Libsigcplusplus < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  @_ver = '2.10.6'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libsigcplusplus/libsigcplusplus/archive/#{@_ver}.tar.gz"
  source_sha256 '3458b027f44204571a3a7091ebb94e5b1b5ecc7fbab89ce2bada25543645993f'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.6-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.6-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.6-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e94e9f2da752623773a8b832204ab57e814bfb3c9132942b079e87f84f3c0ba3',
      armv7l: 'e94e9f2da752623773a8b832204ab57e814bfb3c9132942b079e87f84f3c0ba3',
        i686: '4fa4524d137e1d7a78b166808923fb1470664fd0523ea23320d951859f0bc5c4',
      x86_64: '5fca09ea7258aa2edfba573da8366f40ab5aae476b3df248fb556cfe4bcdd8a0',
  })

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dmaintainer-mode=true \
    -Dbuild-deprecated-api=true \
    -Dbuild-examples=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
