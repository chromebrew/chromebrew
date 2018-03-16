require 'package'

class Libxfixes < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '5.0.3-0'
  source_url 'https://www.x.org/archive/individual/lib/libXfixes-5.0.3.tar.gz'
  source_sha256 '9ab6c13590658501ce4bd965a8a5d32ba4d8b3bb39a5a5bc9901edffc5666570'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfixes-5.0.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxfixes-5.0.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxfixes-5.0.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfixes-5.0.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '46dba76831c0ff2458b76022c57c9c123340915c2126b70aad6a7d031c82a35e',
     armv7l: '46dba76831c0ff2458b76022c57c9c123340915c2126b70aad6a7d031c82a35e',
       i686: '0b20661456a881be0f0ac34833b096cec7c32355fbc4db0594014ba8af7ba34c',
     x86_64: 'a4d50d68f16ed1937fdfc8ee693c5dd8fac28050673da9834f97fba472449bab',
  })

  depends_on 'fixesproto'
  depends_on 'xproto'
  depends_on 'xextproto'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
