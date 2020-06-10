require 'package'

class Xbitmaps < Package
  description 'The xbitmaps package contains bitmap images used by multiple applications built in Xorg chapter.'
  homepage 'http://www.x.org'
  version '1.1.1'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/data/xbitmaps-1.1.1.tar.bz2'
  source_sha256 '3671b034356bbc4d32d052808cf646c940ec8b2d1913adac51b1453e41aa1e9d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xbitmaps-1.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xbitmaps-1.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xbitmaps-1.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xbitmaps-1.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f593f78a6db4cf69e97da6a07e954971a8623164799161bca5fd7e717085720d',
     armv7l: 'f593f78a6db4cf69e97da6a07e954971a8623164799161bca5fd7e717085720d',
       i686: 'c02b3e780b87551954cf975020a5065a8277f935f769b5d56fe80b8ccfd8b50d',
     x86_64: '161b342836f77df11606c5fa965b38912022d108569313d504a0bc5d1bce4c16',
  })

  depends_on 'util_macros' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
