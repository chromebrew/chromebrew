require 'package'

class Libxvid < Package
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.5'
  compatibility 'all'
  source_url 'https://downloads.xvid.com/downloads/xvidcore-1.3.5.tar.bz2'
  source_sha256 '7c20f279f9d8e89042e85465d2bcb1b3130ceb1ecec33d5448c4589d78f010b4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxvid-1.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxvid-1.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxvid-1.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxvid-1.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0587f20f1a2ea2ede14054ccddfc2fbef2a0ef5b611c3ba679c0d1724da365eb',
     armv7l: '0587f20f1a2ea2ede14054ccddfc2fbef2a0ef5b611c3ba679c0d1724da365eb',
       i686: '2d398811d6468a57dd236907d7b2e8a71263fba2423d3baf4d04f8f1b7ac5b1a',
     x86_64: 'e990606cef5b83dcffa96e6595538240934c6f926ca49701c165322811f8a44f',
  })

  depends_on 'yasm'

  def self.build
    FileUtils.cd('build/generic') do
      system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build/generic') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
