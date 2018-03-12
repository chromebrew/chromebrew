require 'package'

class Libfdkaac < Package
  description 'A standalone library of the Fraunhofer FDK AAC code from Android.'
  homepage 'https://github.com/mstorsjo/fdk-aac/'
  version '0.1.6 '
  source_url 'https://github.com/mstorsjo/fdk-aac/archive/v0.1.6.tar.gz'
  source_sha256 'adbcd793e406e1b88b3c1c41382d49f8c27371485b823c0fdab69c9124fd2ce3'



  depends_on 'automake'

  def self.build
    system "./autogen.sh"
    system "./configure  --prefix=#{CREW_PREFIX}  --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
