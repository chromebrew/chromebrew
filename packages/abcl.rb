require 'package'

class Abcl < Package
  description 'Armed Bear Common Lisp (ABCL) is a full implementation of the Common Lisp language featuring both an interpreter and a compiler, running in the JVM.'
  homepage 'https://abcl.org/'
  version '1.9.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://abcl.org/releases/#{version}/abcl-bin-#{version}.tar.gz"
  source_sha256 'dbf7fc10cf80657cf9bca7d349020fd021b92d6294bbd74b111873ccb7b2134e'

  depends_on 'openjdk17'

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
