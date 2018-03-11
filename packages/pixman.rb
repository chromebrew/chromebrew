require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.34.0-0'
  source_url 'https://www.cairographics.org/releases/pixman-0.34.0.tar.gz'
  source_sha256 '21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
