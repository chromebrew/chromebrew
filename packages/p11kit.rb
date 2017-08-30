require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.2-2'
  source_url 'https://p11-glue.freedesktop.org/releases/p11-kit-0.23.2.tar.gz'
  source_sha256 'ba726ea8303c97467a33fca50ee79b7b35212964be808ecf9b145e9042fdfaf0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.2-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.2-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.2-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.2-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e606b415d96f13a5c5e38c1ccbc6be2e7396a5665d24effdd3bcd73f0797a68f',
     armv7l: 'e606b415d96f13a5c5e38c1ccbc6be2e7396a5665d24effdd3bcd73f0797a68f',
       i686: 'b11af19cae225bf86d2c8b38639672b0121f7b8af4a3b06432455f723f23431d',
     x86_64: '94f3f46a6506a49d0c07783854dc09d6cfedee9bf1a310e4e84b6cb7f611fe3f',
  })

  depends_on 'diffutils' => :build
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
