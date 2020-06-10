require 'package'

class Iptraf < Package
  description 'IPTraf is a console-based network statistics utility for Linux.'
  homepage 'http://iptraf.seul.org/'
  version '3.0.0'
  compatibility 'all'
  source_url 'ftp://iptraf.seul.org/pub/iptraf/iptraf-3.0.0.tar.gz'
  source_sha256 '9ee433d95573d612539da4b452e6cdcbca6ab6674a88bfbf6eaf12d4902b5163'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iptraf-3.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iptraf-3.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iptraf-3.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iptraf-3.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0961b50adbce4ce969559f556621debee9a6e29886202063eeeaca5a898bc64',
     armv7l: 'f0961b50adbce4ce969559f556621debee9a6e29886202063eeeaca5a898bc64',
       i686: '74cb84691008e78b2c8592f647b65fc416f93139278883c06f1783b3c4efbfc6',
     x86_64: '3b1c16b812628599c72e853783eec2b7f144b18c3c5b3d2eda1ecacd8e006b0e',
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' Setup"
    FileUtils.cd('support') do
      system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' Makefile"
    end
    FileUtils.cd('src') do
      system "sed -i 's,/var/local,#{CREW_PREFIX},' Makefile"
      system "sed -i 's,/var/log,#{CREW_PREFIX}/logs,' Makefile"
      system "sed -i 's,/var/run,#{CREW_PREFIX}/run,' Makefile"
      system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' Makefile"
      system "sed -i 's,/usr/local/iptraf,#{CREW_PREFIX}/share/iptraf,g' Makefile"
      system "sed -i 's,/var/local,#{CREW_PREFIX},' dirs.h"
      system "sed -i 's,/var/log,#{CREW_PREFIX}/logs,' dirs.h"
      system "sed -i 's,/var/run,#{CREW_PREFIX}/run,' dirs.h"
      system "sed -i 's,linux/if_tr.h,netinet/if_tr.h,' tcptable.h"
      system "sed -i 's,linux/if_tr.h,netinet/if_tr.h,' packet.c"
      system "sed -i 's,linux/if_tr.h,netinet/if_tr.h,' othptab.c"
      system "sed -i 's,linux/if_tr.h,netinet/if_tr.h,' hostmon.c"
      system "sed -i 's,linux/if_tr.h,netinet/if_tr.h,' tr.c"
    end
    system "bash Setup"
  end

  def self.install
    FileUtils.cd('src') do
      system "install -Dm755 iptraf #{CREW_DEST_PREFIX}/bin/iptraf"
      system "install -Dm755 rawtime #{CREW_DEST_PREFIX}/bin/rawtime"
      system "install -Dm755 rvnamed #{CREW_DEST_PREFIX}/bin/rvnamed"
      system "install -Dm644 version #{CREW_DEST_PREFIX}/share/iptraf/version"
      system "touch #{CREW_DEST_PREFIX}/share/iptraf/iptraf.cfg"
    end
  end
end
