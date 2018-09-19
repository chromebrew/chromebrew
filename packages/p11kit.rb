require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.14'
  source_url 'https://github.com/p11-glue/p11-kit/releases/download/0.23.14/p11-kit-0.23.14.tar.gz'
  source_sha256 '1cb9fa6d237539f25f62f4c3d4ec71a1c8e0772957ec45ec5af92134129e0d70'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6957e7f22ee476d529a351dade879a168c6c5f5241e0b1c96c20a93e853ee5a',
     armv7l: 'b6957e7f22ee476d529a351dade879a168c6c5f5241e0b1c96c20a93e853ee5a',
       i686: 'f6b0ba591a68a77173b35eb0694e1178dd476af18e26ac3c7a1928f2612b8fc9',
     x86_64: '748a9021e772591b6133babda14dc52e0f4c95ea7955254d447d0b6ad7ba2df9',
  })

  depends_on 'libffi'
  depends_on 'libtasn1'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic",
      "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Doesn't perform tests since 2 out of 45 fail as
    # reported in https://bugs.freedesktop.org/show_bug.cgi?id=95366
    # system "make", "check"
  end
end
