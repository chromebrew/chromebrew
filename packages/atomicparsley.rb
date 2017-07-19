require 'package'

class Atomicparsley < Package
  description 'AtomicParsley is a lightweight command line program for reading, parsing and setting metadata into MPEG-4 files, in particular, iTunes-style metadata.'
  homepage 'https://github.com/wez/atomicparsley'
  version '0.9.6'
  source_url 'https://bitbucket.org/wez/atomicparsley/get/0.9.6.tar.gz'
  source_sha256 '8ba4e3e21d7a9239932e2a6f34842194d8f9eba84ce9eb83fb35369f5f3f05ab'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'zlibpkg'

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
