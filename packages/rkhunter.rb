require 'package'

class Rkhunter < Package
  description 'Rootkit Hunter, security monitoring and analyzing tool for POSIX compliant systems.'
  homepage 'http://rkhunter.sourceforge.net/'
  version '1.4.4-1'
  source_url 'https://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.4/rkhunter-1.4.4.tar.gz'
  source_sha256 'a8807c83f9f325312df05aa215fa75ad697c7a16163175363c2066baa26dda77'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "sed -i 's,/var\",#{CREW_PREFIX}/share\",g' installer.sh"
    system "sed -i 's,/var/,#{CREW_PREFIX}/share/,g' installer.sh"
    system "bash installer.sh --layout #{CREW_PREFIX} --install"
    system "gzip -9 #{CREW_PREFIX}/share/man/man8/rkhunter.8"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/etc"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/doc"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/lib"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man8"
    system "cp #{CREW_PREFIX}/bin/rkhunter #{CREW_DEST_PREFIX}/bin"
    system "cp #{CREW_PREFIX}/etc/rkhunter.conf #{CREW_DEST_PREFIX}/etc"
    system "cp -r #{CREW_LIB_PREFIX}/rkhunter #{CREW_DEST_LIB_PREFIX}"
    system "cp -r #{CREW_PREFIX}/share/doc/rkhunter-1.4.4 #{CREW_DEST_PREFIX}/share/doc"
    system "cp -r #{CREW_PREFIX}/share/lib/rkhunter #{CREW_DEST_PREFIX}/share/lib"
    system "cp #{CREW_PREFIX}/share/man/man8/rkhunter.8.gz #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
