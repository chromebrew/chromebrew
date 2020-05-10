require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.10'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.10.tar.xz'
  source_sha256 '8425ccac99872d544d4310305f915f5ea81e04d0f437ef1a230dc9d1c819d7c0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gzip-1.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gzip-1.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gzip-1.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gzip-1.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f06dff71bad212d9a9032bb2d2ede8e8d749a6d629404d0c60a70fe34485fd04',
     armv7l: 'f06dff71bad212d9a9032bb2d2ede8e8d749a6d629404d0c60a70fe34485fd04',
       i686: '16c9345b17e82ce949db29462142fbd06dd38d647321e046c9626cd08b6766d1',
     x86_64: '70e752fbb1b545a0fa3189571d3179a46eaa2331485475aaa349420407529422',
  })

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
