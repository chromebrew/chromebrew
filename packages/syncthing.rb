require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '0.14.41'
  source_url 'https://github.com/syncthing/syncthing/archive/v0.14.41.tar.gz'
  source_sha256 '9c406897443465e03d3259df1dda10bd86e49ae4286f8c855d9f35e47026af2f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'go' => :build

  def self.build
    #The system tmp dir is mounted noexec, and the build will fail if it is used
    system "TMPDIR=/usr/local/tmp go run build.go -version v0.14.40"
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
    system "rm -rf /usr/local/tmp/syncthing-*/"
  end
end
