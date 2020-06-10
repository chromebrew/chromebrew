require 'package'

class Rkhunter < Package
  description 'Rootkit Hunter, security monitoring and analyzing tool for POSIX compliant systems.'
  homepage 'http://rkhunter.sourceforge.net/'
  version '1.4.4-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.4/rkhunter-1.4.4.tar.gz'
  source_sha256 'a8807c83f9f325312df05aa215fa75ad697c7a16163175363c2066baa26dda77'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rkhunter-1.4.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rkhunter-1.4.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rkhunter-1.4.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rkhunter-1.4.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '878cd4755b1a3d84a0ae8a07a6d1e4a852d47c642bcb292def0dac9f4b4acea7',
     armv7l: '878cd4755b1a3d84a0ae8a07a6d1e4a852d47c642bcb292def0dac9f4b4acea7',
       i686: 'ad196f3b719562c2b88793d1079fff771af01f6b29d61a3dcd4f60b1d0a77ed0',
     x86_64: '4e36249500cdfa3e1703608a65ef2610196a3d9311fe5edff14c25cbd9528959',
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
