require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.40.0-0'
  compatibility 'all'
  source_url 'https://www.cairographics.org/releases/pixman-0.40.0.tar.gz'
  source_sha256 '6d200dec3740d9ec4ec8d1180e25779c00bc749f94278c8b9021f5534db223fc'

  depends_on 'llvm' => ':build'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
