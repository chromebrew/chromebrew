require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '2.5.7'
  compatibility 'all'
  source_url 'https://cisofy.com/files/lynis-2.5.7.tar.gz'
  source_sha256 '95a6b8249b729d6c431377015c53724d3d267b74c2c9e5596a4d1c59c15df64c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-2.5.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-2.5.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-2.5.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-2.5.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e12dd40c61fff75b1c32c6d3e9dee10458183ba39537578c049e5dff3ed67cc',
     armv7l: '2e12dd40c61fff75b1c32c6d3e9dee10458183ba39537578c049e5dff3ed67cc',
       i686: 'aab3f5715cfa6c9b944b1ce88ef3d4603e84c9bc24d19bd6e126b892eb862246',
     x86_64: '4c728a9fd76868b3ea84e04cd7ae0ad88d68a59d09d6374cff36557a8a87061b',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man8"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/lynis"
    system "gzip -9 lynis.8"
    system "mv lynis.8.gz #{CREW_DEST_PREFIX}/man/man8"
    system "cp -r . #{CREW_DEST_PREFIX}/share/lynis"
    system "echo '#!/bin/bash' > lynis"
    system "echo 'PWD=\$(pwd)' >> lynis"
    system "echo 'cd #{CREW_PREFIX}/share/lynis' >> lynis"
    system "echo './lynis \"\$@\"' >> lynis"
    system "echo 'cd \$PWD' >> lynis"
    system "chmod +x lynis"
    system "cp lynis #{CREW_DEST_PREFIX}/bin"
  end
end
