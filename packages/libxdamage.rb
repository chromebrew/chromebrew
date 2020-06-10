require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.4-1'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXdamage-1.1.4.tar.gz'
  source_sha256 '4bb3e9d917f5f593df2277d452926ee6ad96de7b7cd1017cbcf4579fe5d3442b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'efd0c9702116e4aec5cf5474d9b7d8e838baaf2c1b5990e4ad48290085f2b42d',
     armv7l: 'efd0c9702116e4aec5cf5474d9b7d8e838baaf2c1b5990e4ad48290085f2b42d',
       i686: '56d02bc914ca1fd84986ab5fbc00e63c7f704985d291ef52ef03358c51b67883',
     x86_64: 'ec0c7da854f939617bb29730726f7488a0df1cc0bfb4fd96cbdf6e257890f678',
  })

  depends_on 'libxfixes'
  depends_on 'libx11'


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
