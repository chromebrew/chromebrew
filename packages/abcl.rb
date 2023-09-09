require 'package'

class Abcl < Package
  description 'Armed Bear Common Lisp (ABCL) is a full implementation of the Common Lisp language featuring both an interpreter and a compiler, running in the JVM.'
  homepage 'https://abcl.org/'
  version '1.9.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://abcl.org/releases/1.9.2/abcl-bin-1.9.2.tar.gz'
  source_sha256 '24970976b3565ddf32a1e0b17c5034a9996df25404ec44f240505b01c68a37fe'

  depends_on 'openjdk8'

  no_compile_needed

  def self.build
    abcl = <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/abcl/abcl.jar
    EOF
    File.write('abcl.sh', abcl)
  end

  def self.install
    FileUtils.install 'abcl.sh', "#{CREW_DEST_PREFIX}/bin/abcl", mode: 0o755
    FileUtils.install ['abcl.jar', 'abcl-contrib.jar', "abcl-#{version}.pdf", 'asdf.pdf', 'README'],
                      "#{CREW_DEST_PREFIX}/share/abcl", mode: 0o644
  end
end
