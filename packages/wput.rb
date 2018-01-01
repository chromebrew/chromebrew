require 'package'

class Wput < Package
  description 'wput is a command line file upload tool, the opposite of wget'
  homepage 'http://wput.sourceforge.net/'
  version '0.6.2'
  source_url 'https://downloads.sourceforge.net/project/wput/wput/0.6.2/wput-0.6.2.tgz'
  source_sha256 '229d8bb7d045ca1f54d68de23f1bc8016690dc0027a16586712594fbc7fad8c7'

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
