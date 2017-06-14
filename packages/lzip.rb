require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'http://www.nongnu.org/lzip/lzip.html'
  version '1.19-1'
  source_url 'http://download.savannah.gnu.org/releases/lzip/lzip-1.19.tar.gz'
  source_sha1 'c6042a786b69e3209112fa991806e2e7e0ba5f07'

  def self.build
    # default -O2 cause run-time segmentation fault on armv7l
    system "./configure", "CXXFLAGS=-Wall -W -O1"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
