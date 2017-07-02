require 'package'

class Mtools < Package
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.18'
  source_url 'https://ftp.gnu.org/gnu/mtools/mtools-4.0.18.tar.bz2'
  source_sha256 '59e9cf80885399c4f229e5d87e49c0c2bfeec044e1386d59fcd0b0aead6b2f85'

  def self.build
    system './configure --without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
