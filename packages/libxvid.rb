require 'package'

class Libxvid < Package
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.4'
  source_url 'http://downloads.xvid.org/downloads/xvidcore-1.3.4.tar.gz'
  source_sha256 '4e9fd62728885855bc5007fe1be58df42e5e274497591fec37249e1052ae316f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxvid-1.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxvid-1.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libxvid-1.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libxvid-1.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '76767ad14d293f66f07c43ca837fad10b78c0f98d67fd5eb00a1a940355d61a7',
     armv7l: '76767ad14d293f66f07c43ca837fad10b78c0f98d67fd5eb00a1a940355d61a7',
       i686: '57164785ff150a29ce3e292b3ac2b49b49152beb8b13e4217d7909f6f7e6adc8',
     x86_64: 'de31167c342fe26b2864265c2b01566bbd4a22254e2479768c87555351da2f36',
  })

  depends_on 'yasm'

  def self.build
    FileUtils.cd('build/generic') do
      system "./configure"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build/generic') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
