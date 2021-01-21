require 'package'

class Libev < Package
  description 'High-performance event loop loosely modelled after libevent'
  homepage 'http://software.schmorp.de/pkg/libev.html'
  version '4.33'
  compatibility 'all'
  source_url 'http://dist.schmorp.de/libev/libev-4.33.tar.gz'
  source_sha256 '507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libev-4.33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libev-4.33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libev-4.33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libev-4.33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5f7069c002c4af865bb190301478f9ab7b40e729e31addf77a35cb4472c8483d',
     armv7l: '5f7069c002c4af865bb190301478f9ab7b40e729e31addf77a35cb4472c8483d',
       i686: 'd079e81b116054cf936fe1d3396582911432b8acc203cbdf3babd1df6e4dac9f',
     x86_64: 'dfb18c0c4dbee0bb6b0ca5cdacbb77ba1fb40f8b77e93f02f791b79871e467c2',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
