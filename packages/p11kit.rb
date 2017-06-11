require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.2-1'
  source_url 'https://p11-glue.freedesktop.org/releases/p11-kit-0.23.2.tar.gz'
  source_sha1 '4da0d7b47935b6cb0f321dd00358b063ae42df71'

  depends_on 'diffutils' => :build
  depends_on 'libffi'
  depends_on 'libtasn1'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic", "--prefix=/usr/local"
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
