require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '7.5'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_7_5_P1.tar.gz'
  source_sha256 '00bfc71a4b8f58554892bae561ea0d7f4a462c6940c16c6c943822baa6ba4f84'

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
