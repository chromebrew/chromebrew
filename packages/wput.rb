require 'package'

class Wput < Package
  description 'wput is a command line file upload tool, the opposite of wget'
  homepage 'http://wput.sourceforge.net/'
  version '0.6.1'
  source_url 'https://prdownloads.sourceforge.net/wput/wput-0.6.1.tgz'
  source_sha256 '67125acab1d520e5d2a0429cd9cf7fc379987f30d5bbed0b0e97b92b554fcc13'

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
