require 'package'

class Libxres < Package
  description 'X.org X-Resource extension client library'
  homepage 'http://www.x.org'
  version '1.2.0'
  source_url 'https://www.x.org/archive/individual/lib/libXres-1.2.0.tar.gz'
  source_sha256 '5b62feee09f276d74054787df030fceb41034de84174abec6d81c591145e043a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxres-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '64bdfcb01f7beb55c24020aa027d93c7423e849402434069860a11464526c82e',
     armv7l: '64bdfcb01f7beb55c24020aa027d93c7423e849402434069860a11464526c82e',
       i686: '8d062a5ca2f946ec4fa9fea1f5f92a0baa48acecf1a7e68af4ca140237e6b1fa',
     x86_64: '7f2546d9a4670bc694f0155a0c89aef6f2aaa74d09e022ac512c8900d340dfad',
  })

  depends_on 'libxext'
  depends_on 'resourceproto'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end