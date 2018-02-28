require 'package'

class Termcap < Package
  description 'A library for sending terminal control codes.'
  homepage 'https://www.gnu.org/software/termutils/'
  version '1.3.1-1'
  source_url 'https://ftpmirror.gnu.org/termcap/termcap-1.3.1.tar.gz'
  source_sha256 '91a0e22e5387ca4467b5bcb18edf1c51b930262fd466d5fda396dd9d26719100'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "install -Dm644 libtermcap.a #{CREW_DEST_LIB_PREFIX}/libtermcap.a"
    system "ranlib #{CREW_DEST_LIB_PREFIX}/libtermcap.a"
    system "install -Dm644 termcap.h #{CREW_DEST_PREFIX}/include/termcap.h"
    system "for f in termcap.info*; do install -Dm644 $f #{CREW_DEST_PREFIX}/info/$f; done"
  end
end
