require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.21'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.21.tar.lz'
  source_sha256 '68c703c7b5198b3fd7a0c3f20011e9a8c938b8dec14824c4c873922fdb01719f'

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
