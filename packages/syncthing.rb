require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '2.1.7'
  license 'Apache-2.0, BSD, BSD-2, ISC, MIT, MPL-2.0 and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/syncthing/syncthing.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '791a47499dcc29d1040a7a50bdc3a454cb499d4ef4738a4b00033ab4ac5d8a3f',
     armv7l: '791a47499dcc29d1040a7a50bdc3a454cb499d4ef4738a4b00033ab4ac5d8a3f',
       i686: '3d27ae1ac009863856bed4f116d934f659b84fbd45d627f9780b63793085e295',
     x86_64: 'd522e390781c860982870ebc368cee91a3d2ee1f68191586d04fa55c034b2458'
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
