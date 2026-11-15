require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '3.1.7'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://downloads.cisofy.com/lynis/lynis-#{version}.tar.gz"
  source_sha256 'b5314a07fd85fa3ffc7da57b508f0108ec3280d84e4af823f805d95cbbc2428c'

  no_compile_needed

  def self.build
    File.write 'lynis.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/lynis
      ./lynis "$@"
    EOF
  end

  def self.install
    FileUtils.install 'lynis.sh', "#{CREW_DEST_PREFIX}/bin/lynis", mode: 0o755
    FileUtils.install 'lynis.8', "#{CREW_DEST_MAN_PREFIX}/man8/lynis.8", mode: 0o644
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/lynis"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/lynis"
  end
end
