require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'http://www.nongnu.org/lzip/lzip.html'
  version '1.19-1'
  source_url 'http://download.savannah.gnu.org/releases/lzip/lzip-1.19.tar.gz'
  source_sha256 'ffadc4f56be1bc0d3ae155ec4527bd003133bdc703a753b2cc683f610e646ba9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.19-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.19-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.19-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.19-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e704210e583ac6ab3ab1ddbbb998dc8fcb659ae756bbfb3fd57bf91ab78105cb',
     armv7l: 'e704210e583ac6ab3ab1ddbbb998dc8fcb659ae756bbfb3fd57bf91ab78105cb',
       i686: '51c97bea8d68e40ae53ac359da5c91760aec10488ce98cbf279b86fee3b0ca97',
     x86_64: 'f847ba5368f6173949d024da6c85d647d4f4a27034b03e157a862d4635c872a9',
  })

  def self.build
    # default -O2 cause run-time segmentation fault on armv7l
    system "./configure", "CXXFLAGS=-Wall -W -O1"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
