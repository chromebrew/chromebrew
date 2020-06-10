require 'package'

class Ncrack < Package
  description "Ncrack is a high-speed network authentication cracking tool."
  homepage 'https://nmap.org/ncrack/'
  version '0.5'
  compatibility 'all'
  source_url 'https://nmap.org/ncrack/dist/ncrack-0.5.tar.gz'
  source_sha256 'dbad9440c861831836d47ece95aeb2bd40374a3eb03a14dea0fe1bfa73ecd4bc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncrack-0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncrack-0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncrack-0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncrack-0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94ff9ab741817018e2501ee7047a913cb921429a02b55b2ca2c9ae84a1c2e0c1',
     armv7l: '94ff9ab741817018e2501ee7047a913cb921429a02b55b2ca2c9ae84a1c2e0c1',
       i686: '9ef45c87ac193be024430bc75191153973434f5fbbaf03c7a3fb12b28b2581d0',
     x86_64: '285603cd26d6bf1a4a1103d52726157b6491d6611ea4188edd8ccee2eaae9426',
  })

  depends_on 'buildessential'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
