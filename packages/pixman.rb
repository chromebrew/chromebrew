require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.34.0-0'
  compatibility 'all'
  source_url 'https://www.cairographics.org/releases/pixman-0.34.0.tar.gz'
  source_sha256 '21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.34.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.34.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.34.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.34.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '056ddb91ba2761a2c742fe47edb02c9a2dd2a2ae89ff06b5a4733d346ee488ff',
     armv7l: '056ddb91ba2761a2c742fe47edb02c9a2dd2a2ae89ff06b5a4733d346ee488ff',
       i686: '07e84363add2a3e345340243af5fe39dc7c2b1d5fd3d5252bb64080b86abf12c',
     x86_64: 'c268902b79b7dffe7214fb0f561e9ecdb9be47309d2440da3a386cabe3ba4370',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
