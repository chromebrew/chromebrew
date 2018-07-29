require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.12'
  source_url 'https://github.com/p11-glue/p11-kit/releases/download/0.23.12/p11-kit-0.23.12.tar.gz'
  source_sha256 '58bae22f19db1de1a1103e7ca4149eed6e303e727878c2cd5ea9e6fe445fd403'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c9c3d841ccc2d45536c9a8329f8661091d0d23aeea1a8bb62d0f2c4e86116167',
     armv7l: 'c9c3d841ccc2d45536c9a8329f8661091d0d23aeea1a8bb62d0f2c4e86116167',
       i686: '0d93fde738b8cfd25545ea5d269d8dcf9597c5b278be063d7a4dda4af12a1608',
     x86_64: '581a24c662d39ea82b8bf40528f496ccee5bcefd00d342b9fa24ccb2c5deb74c',
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
