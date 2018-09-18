require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'http://www.nongnu.org/lzip/lzip.html'
  version '1.20'
  source_url 'http://download.savannah.gnu.org/releases/lzip/lzip-1.20.tar.gz'
  source_sha256 'c93b81a5a7788ef5812423d311345ba5d3bd4f5ebf1f693911e3a13553c1290c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzip-1.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7cbe7a366aed4da37ffe6fe1cbae057917879559f794803d613d0421f71a92e8',
     armv7l: '7cbe7a366aed4da37ffe6fe1cbae057917879559f794803d613d0421f71a92e8',
       i686: 'e64bad3920d72f7e5e5c952c5ee3870f40448c0d833377631dd67e54a3de2c37',
     x86_64: 'dbbc38602aaeb84e11d971aeb35d64b49fc30d44354b902b767e0529a3ce7d04',
  })

  def self.build
    # default of -O2 causes a run-time segmentation fault on armv7l
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
