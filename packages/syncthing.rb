require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '0.14.41'
  compatibility 'all'
  source_url 'https://github.com/syncthing/syncthing/archive/v0.14.41.tar.gz'
  source_sha256 '9c406897443465e03d3259df1dda10bd86e49ae4286f8c855d9f35e47026af2f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/syncthing-0.14.41-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/syncthing-0.14.41-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/syncthing-0.14.41-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/syncthing-0.14.41-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '49a1232c9bb8889c28b47e6663a93392a0e97f5501e37ec5725b0e2a94945eee',
     armv7l: '49a1232c9bb8889c28b47e6663a93392a0e97f5501e37ec5725b0e2a94945eee',
       i686: 'a7cce6d9cf389f991a29ead1212c11c77ae78b9f7093e739c56b19c5ef0d6d9b',
     x86_64: '60c9415478f1f640043ca18cfce40afa60c623d734e80df191620e1e2b935379',
  })

  depends_on 'go' => :build

  def self.build
    #The system tmp dir is mounted noexec, and the build will fail if it is used
    system "TMPDIR=#{CREW_PREFIX}/tmp go run build.go -version v0.14.40"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mv bin/syncthing #{CREW_DEST_PREFIX}/bin/syncthing-bin"

    [ 1, 5, 7 ].each do |i|
        system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man#{i}"
        system "gzip man/*.#{i}"
        system "cp -R man/*.#{i}.gz #{CREW_DEST_PREFIX}/share/man/man#{i}"
    end

    #syncthing requires some ports to be open
    system %Q(echo '#!/bin/bash
if [[ $EUID == 0 ]]; then
    echo "Do not run syncthing as root."
    echo "This wrapper script calls iptables with sudo to open ports for syncthing."
    echo "syncthing run as root will try and fail to write to the read-only root directory."
    exit
fi

#syncthing listens on these ports
sudo /sbin/iptables -I INPUT -p tcp --dport 22000 -j ACCEPT &&
sudo /sbin/iptables -I INPUT -p udp --dport 21025 -j ACCEPT &&

syncthing-bin "$@"

#clean up created rules to avoid duplicating them
sudo /sbin/iptables -D INPUT -p tcp --dport 22000 -j ACCEPT
sudo /sbin/iptables -D INPUT -p udp --dport 21025 -j ACCEPT
' > #{CREW_DEST_PREFIX}/bin/syncthing)
    system "chmod +x #{CREW_DEST_PREFIX}/bin/syncthing"

    #The build process leaves 50M of files around that we do not need
    system "rm -rf #{CREW_PREFIX}/tmp/syncthing-*/"
  end
end
