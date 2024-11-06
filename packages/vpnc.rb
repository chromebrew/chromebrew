require 'package'

class Vpnc < Package
  description 'client for cisco vpn concentrator'
  homepage 'https://www.unix-ag.uni-kl.de/~massar/vpnc/'
  version '0.5.3'
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url 'https://www.unix-ag.uni-kl.de/~massar/vpnc/vpnc-0.5.3.tar.gz'
  source_sha256 '46cea3bd02f207c62c7c6f2f22133382602baeda1dc320747809e94881414884'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e7bbf197b1c330a774aebeb33470879b3de0766059f370848ded4ade66776eb5',
     armv7l: 'e7bbf197b1c330a774aebeb33470879b3de0766059f370848ded4ade66776eb5',
       i686: 'eddc90428216a65b95727dd8ecb3a1a9332d2b23e2c42d9e6bd19d6a455eccd1',
     x86_64: '611f400f81432b28476037502b69cf51e8bdd537d49c250d9bf3f287fba07382'
  })

  depends_on 'libgcrypt'

  def self.patch
    system "sed -i 's,\./makeman.pl,perl makeman.pl,' Makefile"
    system "sed -i 's,ETCDIR=/etc/vpnc,ETCDIR=#{CREW_PREFIX}/etc/vpnc,' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
