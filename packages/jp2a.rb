require 'package'

class Jp2a < Package
  description 'jp2a is a simple JPEG/PNG to ASCII converter.'
  homepage 'https://github.com/Talinx/jp2a'
  version '1.1.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/Talinx/jp2a/releases/download/v1.1.0/jp2a-1.1.0.tar.bz2"
  source_sha256 '6017b83f10bae352c7786868a977a02080a4e84fb99e6fbad18086fcfedffdf4'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/jp2a-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/jp2a-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/jp2a-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/jp2a-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23f9ec4aee910371c8a37b464e50270b26e000125c9a5636675ed10c08ac8e16',
     armv7l: '23f9ec4aee910371c8a37b464e50270b26e000125c9a5636675ed10c08ac8e16',
       i686: '7ce07d9769cfe508d021f1fb17d7969c8f986c577a1f903de764890165824f18',
     x86_64: '981baefcffa4d9cc67758003cd068235b074b7200e1ffed05d0f5ce76116f089',
  })
  
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'termcap'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-curl"
    system "make"
  end

  def self.check
    system "make check || true"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
