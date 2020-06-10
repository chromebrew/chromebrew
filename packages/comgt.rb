require 'package'

class Comgt < Package
  description 'Comgt is a command line tool for controlling, configuring and interacting with Option Wireless 3G and 2G (HSDPA, UMTS, EDGE, GPRS, GSM) data devices within the Linux environment.'
  homepage 'https://sourceforge.net/projects/comgt/'
  version '0.32'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/comgt/comgt/0.32/comgt.0.32.tgz'
  source_sha256 '0cedb2a5aa608510da66a99aab74df3db363df495032e57e791a2ff55f1d7913'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/comgt-0.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/comgt-0.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/comgt-0.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/comgt-0.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '845637e6a37fa17dbeafcd62244ed3b4cbfb275c31a23dffe8b0b87527ba59d6',
     armv7l: '845637e6a37fa17dbeafcd62244ed3b4cbfb275c31a23dffe8b0b87527ba59d6',
       i686: 'c0a0bab50a6621dd56c16b8947917477408583624816beea71ff115b26241196',
     x86_64: '8f6b77dc36fcd3404a0b03f9e69722dea28cad970ad0593b03670bbe0077ec0b',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 comgt #{CREW_DEST_PREFIX}/bin/comgt"
    system "install -Dm644 comgt.1 #{CREW_DEST_PREFIX}/share/man/man1/comgt.1"
    system "install -Dm644 sigmon.1 #{CREW_DEST_PREFIX}/share/man/man1/sigmon.1"
    system "install -Dm755 scripts/dump #{CREW_DEST_PREFIX}/etc/comgt/scripts/dump"
    system "install -Dm755 scripts/sigmon #{CREW_DEST_PREFIX}/etc/comgt/scripts/sigmon"
    system "install -Dm644 scripts/README #{CREW_DEST_PREFIX}/etc/comgt/scripts/README"
    system "install -Dm755 scripts/command #{CREW_DEST_PREFIX}/etc/comgt/scripts/command"
    system "install -Dm755 scripts/operator #{CREW_DEST_PREFIX}/etc/comgt/scripts/operator"
  end
end
