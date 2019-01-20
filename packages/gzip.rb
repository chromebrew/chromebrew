require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.10'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.10.tar.xz'
  source_sha256 '8425ccac99872d544d4310305f915f5ea81e04d0f437ef1a230dc9d1c819d7c0'

  binary_url ({
  })
  binary_sha256 ({
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
