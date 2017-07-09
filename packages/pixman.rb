require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.34.0'
  source_url 'https://www.cairographics.org/releases/pixman-0.34.0.tar.gz'
  source_sha256 '21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pixman-0.34.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pixman-0.34.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pixman-0.34.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pixman-0.34.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3766cd7ccd408413249e2e416fcc056aa78d0174801f0714203578628d4320c4',
     armv7l: '3766cd7ccd408413249e2e416fcc056aa78d0174801f0714203578628d4320c4',
       i686: '3a1d49c14c3bff1a39ea72a56c486360fcc446f5b57256facbc6df9624d08521',
     x86_64: '44c139f5d83ea96445890b651271ef2c4e2f518deb3875573b50a69f73bdd5b8',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
