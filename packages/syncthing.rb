require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '2.0.15'
  license 'Apache-2.0, BSD, BSD-2, ISC, MIT, MPL-2.0 and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/syncthing/syncthing.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '555e9f6e5f9bb2a2955136cb0fc603b6e8cfb52164575a6570a953bce24d0f94',
     armv7l: '555e9f6e5f9bb2a2955136cb0fc603b6e8cfb52164575a6570a953bce24d0f94',
       i686: '6297476e370f68df0f03901c104d42fce5cedad2bae3470591287518e8d4b6be',
     x86_64: 'b539dc320ed13eaf2a3ba524758607ea9dbd366c5e5f6e307e4aab96cd9a894e'
  })

  depends_on 'glibc' => :executable
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
