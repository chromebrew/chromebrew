require 'package'

class Lcms < Package
  description 'Little CMS intends to be an OPEN SOURCE small-footprint color management engine, with special focus on accuracy and performance.'
  homepage 'http://www.littlecms.com/'
  version '2.9'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/lcms/lcms2-2.9.tar.gz'
  source_sha256 '48c6fdf98396fa245ed86e622028caf49b96fa22f3e5734f853f806fbc8e7d20'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lcms-2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lcms-2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lcms-2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lcms-2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e99a0236ce9f49f2a73fbc3b796112c0bc548c8bf6bb6af454e2b8c8fca5fd7',
     armv7l: '4e99a0236ce9f49f2a73fbc3b796112c0bc548c8bf6bb6af454e2b8c8fca5fd7',
       i686: '468dcb84ddeb0b7f4f486f766e7530e60ecdb020b5457cc65b5dbc3e5e0137d5',
     x86_64: '47e4c1c86f4a455920106d10bfa4ec8cd47f36e41b71ea27e3bac6551a09d68c',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
