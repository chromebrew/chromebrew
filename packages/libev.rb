require 'package'

class Libev < Package
  description 'High-performance event loop loosely modelled after libevent'
  homepage 'http://software.schmorp.de/pkg/libev.html'
  version '4.33'
  compatibility 'all'
  source_url 'http://dist.schmorp.de/libev/libev-4.33.tar.gz'
  source_sha256 '507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea'
  
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
