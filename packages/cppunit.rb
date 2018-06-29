require 'package'

class Cppunit < Package
  description 'CppUnit is the C++ port of the famous JUnit framework for unit testing.'
  homepage 'https://sourceforge.net/projects/cppunit/'
  version '1.12.1'
  source_url 'http://downloads.sourceforge.net/project/cppunit/cppunit/1.12.1/cppunit-1.12.1.tar.gz'
  source_sha256 'ac28a04c8e6c9217d910b0ae7122832d28d9917fa668bcc9e0b8b09acb4ea44a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cppunit-1.12.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cppunit-1.12.1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cppunit-1.12.1-chromeos-x86_64.tar.xz',
    i686: 'file:///home/chronos/user/chromebrew/release/i686/cppunit-1.12.1-chromeos-i686.tar.xz'
  })
  binary_sha256 ({
    aarch64: '5629277d1bb357eb5a1f0cf6a0febe1078b67c63030ecf9c51cf885704c76107',
     armv7l: '5629277d1bb357eb5a1f0cf6a0febe1078b67c63030ecf9c51cf885704c76107',
     x86_64: 'e5f432ecd193119cb7201eec9881f3e89dd7bccbb78f3ba4cc8374471acbe236',
       i686: '3a4a325fb9e1ef07883f08dfe0dd97f09505bf8b3189540a5b8a1c13902ab7b9',
  })

  depends_on 'doxygen' => :build
  depends_on 'graphviz' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
