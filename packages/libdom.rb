require 'package'

class Libdom < Package
  description 'Implementation of the W3C DOM, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.4.1'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libdom-0.4.1-src.tar.gz'
  source_sha256 '98ee072471e55e208c9878e515c410ad462ca36f87b4afcbecad023f3a2cef4a'

  depends_on 'expat'
  depends_on 'libparserutils'
  depends_on 'libwapcaplet'
  depends_on 'libhubbub'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} DESTDIR=#{CREW_DEST_DIR} install PREFIX=#{CREW_PREFIX}"
  end
end