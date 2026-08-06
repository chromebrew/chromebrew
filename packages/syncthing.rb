require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '2.1.3'
  license 'Apache-2.0, BSD, BSD-2, ISC, MIT, MPL-2.0 and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/syncthing/syncthing.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64dac852663327d0a7544d95395659084222f704ac1920917894259cb9a385e3',
     armv7l: '64dac852663327d0a7544d95395659084222f704ac1920917894259cb9a385e3',
       i686: 'd8c9a4886477af1b825d3bc1129eee38089d89c72bf7fd67ebe2c60f35c4b797',
     x86_64: 'bd26a1ec9ca21844e50bffc3c3097015a85b747a11a698c968dc7deb5983a1bb'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.build
    # The system tmp dir is mounted noexec, and the build will fail if it is used
    system 'go run build.go -version v0.14.40'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mv bin/syncthing #{CREW_DEST_PREFIX}/bin/syncthing-bin"

    [1, 5, 7].each do |i|
      system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man#{i}"
      system "gzip man/*.#{i}"
      system "cp -R man/*.#{i}.gz #{CREW_DEST_PREFIX}/share/man/man#{i}"
    end

    # syncthing requires some ports to be open
    system %(echo '#!/bin/bash
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

    # The build process leaves 50M of files around that we do not need
    system "rm -rf #{CREW_PREFIX}/tmp/syncthing-*/"
  end
end
