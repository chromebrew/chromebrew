require 'package'

class Cairomm_1_0 < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  @_ver = '1.14.2'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://www.cairographics.org/releases/cairomm-#{@_ver}.tar.xz"
  source_sha256 '0126b9cc295dc36bc9c0860d5b720cb5469fd78d5620c8f10cc5f0c07b928de3'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/cairomm_1_0-1.14.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/cairomm_1_0-1.14.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/cairomm_1_0-1.14.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/cairomm_1_0-1.14.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '43377afdfd60e5d6de950d883d7053c5f21dc2fe7b87b99d60b51de2c16e480d',
     armv7l: '43377afdfd60e5d6de950d883d7053c5f21dc2fe7b87b99d60b51de2c16e480d',
       i686: 'b66a27aae76d273e8d365d764efafb4a01703d087dde1f63401b3feff0257ad0',
     x86_64: '3ec47e52333e93b341c65d1af2d58bb51c6d60a9b4023b20b2b8c04fd5a42b5e'
  })

  depends_on 'cairo'
  depends_on 'libsigcplusplus3'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
