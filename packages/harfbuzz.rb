require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '2.6.4'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/2.6.4/harfbuzz-2.6.4.tar.xz'
  source_sha256 '9413b8d96132d699687ef914ebb8c50440efc87b3f775d25856d7ec347c03c12'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-2.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8e4b59ff79cf7d445693aaf4cb3b942551d927be47436a70114e286947c5ee6',
     armv7l: 'a8e4b59ff79cf7d445693aaf4cb3b942551d927be47436a70114e286947c5ee6',
       i686: '10aa0c94e9a04d86ae06d9508aac0a1224942dffd2d3982aa7a7e27c14499ccf',
     x86_64: '76d5d648508cb2a85c128d8a0a529ea0f57ff86982ddf5c1aa3fb277d76825dc',
  })

  depends_on 'glib'
  depends_on 'freetype_sub'
  depends_on 'six' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
