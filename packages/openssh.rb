require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '7.5'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_7_5_P1.tar.gz'
  source_sha1 '3c5d829be2d30ed80feef708231ec223cd37b264'

  depends_on 'buildessential'
  depends_on 'autoconf'

  def self.build
    system "autoconf"
    system "autoheader"
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
