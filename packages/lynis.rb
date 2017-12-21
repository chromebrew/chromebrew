require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '2.5.7'
  source_url 'https://cisofy.com/files/lynis-2.5.7.tar.gz'
  source_sha256 '95a6b8249b729d6c431377015c53724d3d267b74c2c9e5596a4d1c59c15df64c'

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
