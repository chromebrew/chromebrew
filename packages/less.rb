require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '487-1'
  source_url 'http://www.greenwoodsoftware.com/less/less-487.tar.gz'
  source_sha256 'f3dc8455cb0b2b66e0c6b816c00197a71bf6d1787078adeee0bcf2aea4b12706'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/less-487-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/less-487-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/less-487-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/less-487-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b8121181edca892d7d552375e0943af58bd2e4b203466d85e560e41a570e2638',
     armv7l: 'b8121181edca892d7d552375e0943af58bd2e4b203466d85e560e41a570e2638',
       i686: '01484da1a6be5af400f1b6f238cd13f84865e359d18eaae8f30edf71e302325f',
     x86_64: 'e3b116acea3eff0dfb87c38b37751bf561268c1b9305b4ef91be8eb3cc5a939e',
  })

  depends_on 'compressdoc' => :build
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --with-regex=posix"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end

  def self.check
    system "make", "check"
  end
end
