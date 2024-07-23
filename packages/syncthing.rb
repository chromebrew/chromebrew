require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '1.27.8'
  license 'Apache-2.0, BSD, BSD-2, ISC, MIT, MPL-2.0 and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/syncthing/syncthing.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1865ca5f24ce62e6383b1c07092948770808b7649d2cb32dc1b58c3d037f49e7',
     armv7l: '1865ca5f24ce62e6383b1c07092948770808b7649d2cb32dc1b58c3d037f49e7',
       i686: 'a7c249d41db77937937f0b54cc5d4fe8b9479d42ed3d3d0036befc4082649c5a',
     x86_64: '80a0daafb672e7f98987e1c18c2d4f7886e08d00e994fd12196833179e829143'
  })

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
