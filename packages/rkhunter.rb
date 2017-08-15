require 'package'

class Rkhunter < Package
  description 'Rootkit Hunter, security monitoring and analyzing tool for POSIX compliant systems.'
  homepage 'http://rkhunter.sourceforge.net/'
  version '1.4.4'
  source_url 'https://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.4/rkhunter-1.4.4.tar.gz'
  source_sha256 'a8807c83f9f325312df05aa215fa75ad697c7a16163175363c2066baa26dda77'

  binary_url ({
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/rkhunter-1.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '2517148eec1f494596463c086171e49ca664cb45521638a7f7c555e2df0c4ddb',
  })

  def self.install
    system "sed -i 's,/var\",/usr/local/share\",g' installer.sh"
    system "sed -i 's,/var/,/usr/local/share/,g' installer.sh"
    system "bash installer.sh --layout /usr/local --install"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/etc"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/lib64"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/doc"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/lib"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/man/man8"
    system "cp /usr/local/bin/rkhunter #{CREW_DEST_DIR}/usr/local/bin"
    system "cp /usr/local/etc/rkhunter.conf #{CREW_DEST_DIR}/usr/local/etc"
    system "cp -r /usr/local/lib64/rkhunter #{CREW_DEST_DIR}/usr/local/lib64"
    system "cp -r /usr/local/share/doc/rkhunter-1.4.4 #{CREW_DEST_DIR}/usr/local/share/doc"
    system "cp -r /usr/local/share/lib/rkhunter #{CREW_DEST_DIR}/usr/local/share/lib"
    system "cp /usr/local/share/man/man8/rkhunter.8* #{CREW_DEST_DIR}/usr/local/share/man/man8"
  end
end
