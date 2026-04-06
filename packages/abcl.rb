require 'package'

class Abcl < Package
  description 'Armed Bear Common Lisp (ABCL) is a full implementation of the Common Lisp language featuring both an interpreter and a compiler, running in the JVM.'
  homepage 'https://abcl.org/'
  version '1.10.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://abcl.org/releases/#{version}/abcl-bin-#{version}.tar.gz"
  source_sha256 'db6ed25fe4f3a35d44b4df4f4eee622c9b0e0e0fea45314550c0ae3b6f6d72f3'

  depends_on 'openjdk17'

  no_compile_needed

  def self.build
    File.write 'abcl.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/abcl/abcl.jar
    EOF
  end

  def self.install
    FileUtils.install 'abcl.sh', "#{CREW_DEST_PREFIX}/bin/abcl", mode: 0o755
    FileUtils.install ['abcl.jar', 'abcl-contrib.jar', "abcl-#{version}.pdf", 'asdf.pdf', 'README'],
                      "#{CREW_DEST_PREFIX}/share/abcl", mode: 0o644
  end
end
