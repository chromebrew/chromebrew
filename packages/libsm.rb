require 'package'

class Libsm < Package
  description 'X.org X Session Management Library'
  homepage 'http://www.x.org'
  version '1.2.2'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libSM-1.2.2.tar.gz'
  source_sha256 '14bb7c669ce2b8ff712fbdbf48120e3742a77edcd5e025d6b3325ed30cf120f4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsm-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsm-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsm-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsm-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37e41534cb72c0816c7836f5e042183bc03062367b09d2da556b355be4cd541f',
     armv7l: '37e41534cb72c0816c7836f5e042183bc03062367b09d2da556b355be4cd541f',
       i686: '43c197b6a44e70314c6c6593e719e35b011ac20776ebc9a2114b4af06e6448a0',
     x86_64: '9516fc81d7106f5f611bfd0f47fc4d44bf3562cddf9c2f83a18a50e3960e9386',
  })

  depends_on 'libice'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
