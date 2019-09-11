require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27-1'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz'
  source_sha256 '26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'diffutils' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-shared',
           '--with-cxx-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
