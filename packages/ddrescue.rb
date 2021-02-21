require 'package'

class Ddrescue < Package
  description 'GNU ddrescue is a data recovery tool.'
  homepage 'https://www.gnu.org/software/ddrescue/'
  version '1.25'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ddrescue/ddrescue-1.25.tar.lz'
  source_sha256 'ce538ebd26a09f45da67d3ad3f7431932428231ceec7a2d255f716fa231a1063'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-non-posix"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
