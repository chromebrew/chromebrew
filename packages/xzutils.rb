require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.3-2'
  source_url 'http://tukaani.org/xz/xz-5.2.3.tar.gz'
  source_sha256 '71928b357d0a09a12a4b4c5fafca8c31c19b0e7d3b8ebb19622e96f26dbf28cb'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/xzutils-5.2.3-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/xzutils-5.2.3-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/xzutils-5.2.3-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/xzutils-5.2.3-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '839ead7097adee016986a9992d8cf8f4c91554ade2b6e111f7d0379c595be366',
     armv7l: '839ead7097adee016986a9992d8cf8f4c91554ade2b6e111f7d0379c595be366',
       i686: 'f64e279259996234dc193e8dee3a55738e3b85a299ed952920691942112d4fec',
     x86_64: '933c51b479c58e277b6354913c76be9a021f2436df86b37e8eb3d328b9cd5fc2',
  })

  def self.build
    system "./configure", "--prefix=/usr/local", "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-docs", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
