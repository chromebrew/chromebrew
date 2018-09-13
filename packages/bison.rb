require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.1'
  source_url 'https://ftpmirror.gnu.org/bison/bison-3.1.tar.xz'
  source_sha256 '7c2464ad6cb7b513b2c350a092d919327e1f63d12ff024836acbb504475da5c6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '20ca51ab529fdddad6f00cd32e0e5b8f2824be4f150d3337403ae6050825b0d3',
     armv7l: '20ca51ab529fdddad6f00cd32e0e5b8f2824be4f150d3337403ae6050825b0d3',
       i686: '1c14341e113a500e651383a5197e422d09cc56714bbb00e44f2f217f3ca7c1c8',
     x86_64: 'ce6e119ab793ec25b80af20b14243f408430a28172f4b23dbc23cca8b6811cae',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end
