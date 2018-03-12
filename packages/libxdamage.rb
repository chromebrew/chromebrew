require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.4-0'
  source_url 'https://www.x.org/archive/individual/lib/libXdamage-1.1.4.tar.gz'
  source_sha256 '4bb3e9d917f5f593df2277d452926ee6ad96de7b7cd1017cbcf4579fe5d3442b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdamage-1.1.4-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '52d8da8a4f1cc00f749a464380949d754fe7f8ce41c70a808c031b93a239d462',
     armv7l: '52d8da8a4f1cc00f749a464380949d754fe7f8ce41c70a808c031b93a239d462',
       i686: '20f49056f9a39a1b0c08d760c44f1b3ca8bad1b572b0c67b475f0e0b36d4a5d8',
     x86_64: '4f1552b42c293b8a7282ed13f45bdd9407d113d261aab337bbca75a5f411fe5d',

  })

  depends_on 'fixesproto'
  depends_on 'libxfixes'
  depends_on 'xextproto'
  depends_on 'libx11'
  depends_on 'damageproto'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
