require 'package'

class Libxfixes < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '5.0.3'
  source_url 'https://www.x.org/archive/individual/lib/libXfixes-5.0.3.tar.gz'
  source_sha256 '9ab6c13590658501ce4bd965a8a5d32ba4d8b3bb39a5a5bc9901edffc5666570'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxfixes-5.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxfixes-5.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libxfixes-5.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libxfixes-5.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7cd3419b872fafceaebf4df3a747ddffaf491720635d60f7723af683d436c630',
     armv7l: '7cd3419b872fafceaebf4df3a747ddffaf491720635d60f7723af683d436c630',
       i686: '9583bb5532d07a2c3b3c9678d2ff4237dbfc47828118636b345651e20b4f8c80',
     x86_64: '6ff70e781b5b96e603a3ae840cd7a41d7170a349a5b1b32e6c5e59c4c75b8d6c',
  })

  depends_on 'fixesproto'
  depends_on 'xproto'
  depends_on 'xextproto'
  depends_on 'libx11'
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
