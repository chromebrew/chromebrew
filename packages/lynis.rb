require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '2.5.1'
  source_url 'https://cisofy.com/files/lynis-2.5.1.tar.gz'
  source_sha256 '7a09c6fc71c65d572ca702df7b4394d71f9037484062ef71b76f59a2c498b029'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lynis-2.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lynis-2.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/lynis-2.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/lynis-2.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d0186620efaf80697501ca0f26d5eaeee975aa2f29267a953b64a75ec6d25b2',
     armv7l: '1d0186620efaf80697501ca0f26d5eaeee975aa2f29267a953b64a75ec6d25b2',
       i686: '00317434d66f01cd9a29878a56a45ed9d32ffed108fafc11bf096dd9763bfeef',
     x86_64: '43fe26bded6125326a00d9f44f4119c86f533689284ba30bbbeba92c27c85b4d',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man8"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/lynis"
    system "cp -r . #{CREW_DEST_DIR}/usr/local/share/lynis"
    system "cp lynis.8 #{CREW_DEST_DIR}/usr/local/man/man8"
    system "echo '#!/bin/bash' > lynis"
    system "echo 'PWD=\$(pwd)' >> lynis"
    system "echo 'cd /usr/local/share/lynis' >> lynis"
    system "echo './lynis \$1 \$2 \$3 \$4 \$5 \$6 \$7 \$8 \$9' >> lynis"
    system "echo 'cd \$PWD' >> lynis"
    system "chmod +x lynis"
    system "cp lynis #{CREW_DEST_DIR}/usr/local/bin"
  end
end
