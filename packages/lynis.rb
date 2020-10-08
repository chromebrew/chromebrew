require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '3.0.0'
  compatibility 'all'
  source_url 'https://cisofy.com/files/lynis-3.0.0.tar.gz'
  source_sha256 '7da40f8c52d43b19eb9dc66aaece9c756c2ec581609ffce1a2c510cd99af38e1'

  binary_url ({
    
  })
  binary_sha256 ({
    
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
