require 'package'

class Wput < Package
  description 'wput is a command line file upload tool, the opposite of wget'
  homepage 'http://wput.sourceforge.net/'
  version '0.6.1'
  source_url 'https://prdownloads.sourceforge.net/wput/wput-0.6.1.tgz'
  source_sha256 '67125acab1d520e5d2a0429cd9cf7fc379987f30d5bbed0b0e97b92b554fcc13'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '48230c2499ce7b4f0f144e3b9d8146d15c96dfde44c577cbe9b21dfafd5498ea',
     armv7l: '48230c2499ce7b4f0f144e3b9d8146d15c96dfde44c577cbe9b21dfafd5498ea',
       i686: '2c00e900e41225455efd129b605ec11a027822f43c10d765832261b38ca98311',
     x86_64: '1c2dfc74e86f4b50ad805079b4d9b1e92e10ba6da31060b5de62a8f3af8d06a2',
  })

  depends_on 'gnutls'

  def self.preinstall
    system "curl -Ls -o config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "install -Dm755 wput #{CREW_DEST_PREFIX}/bin/wput"
    system "install -Dm644 doc/wput.1.gz #{CREW_DEST_PREFIX}/man/man1/wput.1.gz"
  end
end
