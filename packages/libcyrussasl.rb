require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27-1'
  compatibility 'all'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz'
  source_sha256 '26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817',
     armv7l: '281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817',
       i686: 'dbce3fbbf6efedd4c9266c14163022ca9a1da22386f55eeffe6074c341a5bac0',
     x86_64: '46241ea5cf5e0181649e91edb183128669d5ab5bc13a938493ba1158a5189743',
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
