require 'package'

class Libxi < Package
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org'
  version '1.7.9'
  source_url 'https://github.com/mirror/libXi/archive/libXi-1.7.9.tar.gz'
  source_sha256 'e3bc48654d4c21ac37592e8b41c87a5de73872a243e7b0fb39ebd565be5b943d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ae20037aa3d29612005e7ebca7770436896683963f6d063e99a8000ad7a5eed',
     armv7l: '7ae20037aa3d29612005e7ebca7770436896683963f6d063e99a8000ad7a5eed',
       i686: '3085dc4c94ece39623fb922b2d72a6eeefc1213578d24fe7197b4a86e386c0bc',
     x86_64: '45f5b9b930badb56fab199c94bc7ba69eb4a32c07413a930f498ecc3047199d6',
  })

  depends_on 'automake' => :build
  depends_on 'libx11'
  depends_on 'util_macros'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
