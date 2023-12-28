require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.7-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/xmlgraphics/fop/binaries/fop-2.7-bin.tar.gz'
  source_sha256 'ec75d6135f55f57b275f8332e069f8817990fdc7f63b1f5c0cb9da5609aa3074'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7-1_armv7l/fop-2.7-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7-1_armv7l/fop-2.7-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7-1_i686/fop-2.7-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7-1_x86_64/fop-2.7-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '592a35d04bcca3ab8762e8ba03ce7f57c10a93f03efecad58f3f9304c3eaa79a',
     armv7l: '592a35d04bcca3ab8762e8ba03ce7f57c10a93f03efecad58f3f9304c3eaa79a',
       i686: 'c6c96e9a3b66a448dc1c30b8cbe64022e2d6cb6a078f879d824ffe143839e56b',
     x86_64: '537463270af9f987c2604b98f46e17bb4b1249a7203e055531822574c7562450'
  })

  depends_on 'openjdk8'

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_LIB_PREFIX}/fop #{CREW_DEST_PREFIX}/etc/env.d/]
    FileUtils.cp_r '.', "#{CREW_DEST_LIB_PREFIX}/fop"

    File.write "#{CREW_DEST_PREFIX}/bin/fop", <<~EOF, perm: 0o755
      #!/bin/bash
      cd #{CREW_LIB_PREFIX}/fop/fop
      ./fop "$@"
    EOF

    @fopenv = <<~FOPEOF
      # Fop configuration
      export JAVA_HOME=#{CREW_PREFIX}/jre
    FOPEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/fop", @fopenv)
  end
end
