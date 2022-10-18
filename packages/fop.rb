require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/xmlgraphics/fop/binaries/fop-2.7-bin.tar.gz'
  source_sha256 'ec75d6135f55f57b275f8332e069f8817990fdc7f63b1f5c0cb9da5609aa3074'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7_armv7l/fop-2.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7_armv7l/fop-2.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7_i686/fop-2.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fop/2.7_x86_64/fop-2.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3b9f80cc072b9f23a54a06f8f83ded64d1c1a4c79ad1f887c79b0ecb5b25da74',
     armv7l: '3b9f80cc072b9f23a54a06f8f83ded64d1c1a4c79ad1f887c79b0ecb5b25da74',
       i686: '525ad8aea3c8c5512a85fb82c01a9569a3bbc858a9b1ca0369d9c430c814ccb4',
     x86_64: '5e36714fdc3db30e7f9df579d47a19bdff8da481ac2665bf4449458f34344629'
  })

  depends_on 'openjdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/fop"
    system "cp -r . #{CREW_DEST_LIB_PREFIX}/fop"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > fop"
      system "echo 'cd #{CREW_LIB_PREFIX}/fop/fop' >> fop"
      system "echo './fop \"$@\"' >> fop"
      system "echo 'cd $PWD' >> fop"
      system 'chmod +x fop'
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @fopenv = <<~FOPEOF
      # Fop configuration
      export JAVA_HOME=#{CREW_LIB_PREFIX}/jdk8
    FOPEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/fop", @fopenv)
  end
end
