require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '2.5.1'
  source_url 'https://cisofy.com/files/lynis-2.5.1.tar.gz'
  source_sha256 '7a09c6fc71c65d572ca702df7b4394d71f9037484062ef71b76f59a2c498b029'

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
