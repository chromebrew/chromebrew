require 'package'

class Vpnc < Package
  description 'client for cisco vpn concentrator'
  homepage 'https://www.unix-ag.uni-kl.de/~massar/vpnc/'
  version '0.5.3'
  source_url 'https://www.unix-ag.uni-kl.de/~massar/vpnc/vpnc-0.5.3.tar.gz'
  source_sha256 '46cea3bd02f207c62c7c6f2f22133382602baeda1dc320747809e94881414884'

  depends_on 'libgcrypt'
  depends_on 'openssl'
  depends_on 'perl'

  def self.build
    system "sed -i 's,\./makeman.pl,perl makeman.pl,' Makefile"
    system "sed -i 's,ETCDIR=/etc/vpnc,ETCDIR=#{CREW_PREFIX}/etc/vpnc,' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
