require 'package'

class Abcl < Package
  description 'Armed Bear Common Lisp (ABCL) is a full implementation of the Common Lisp language featuring both an interpreter and a compiler, running in the JVM.'
  homepage 'https://abcl.org/'
  version '1.9.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://abcl.org/releases/1.9.0/abcl-bin-1.9.0.tar.gz'
  source_sha256 'de6a25cb02d283664c1dae2e8342503aaeb484d95bff3acc19bdae0c6ddae28f'

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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/abcl"
    FileUtils.install 'abcl.sh', "#{CREW_DEST_PREFIX}/bin/abcl", mode: 0o755
    FileUtils.install ['abcl.jar', 'abcl-contrib.jar', "abcl-#{version}.pdf", 'asdf.pdf', 'README'],
                      "#{CREW_DEST_PREFIX}/share/abcl", mode: 0o644
  end
end
