require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.2-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'http://apache.forsale.plus/xmlgraphics/fop/binaries/fop-2.2-bin.tar.gz'
  source_sha256 'd5a89e26beae0bc03ad18a0b0d1d3d75f87c32047879d25da11970cb5c4662a3'

  depends_on 'jdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/fop"
    system "cp -r . #{CREW_DEST_LIB_PREFIX}/fop"
    system "chmod +x #{CREW_DEST_LIB_PREFIX}/fop/fop/fop"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > fop"
      system "echo 'PWD=$(pwd)' >> fop"
      system "echo 'cd #{CREW_LIB_PREFIX}/fop/fop' >> fop"
      system "echo './fop \"$@\"' >> fop"
      system "echo 'cd $PWD' >> fop"
      system "chmod +x fop"
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Fop configuration
      export JAVA_HOME=#{CREW_LIB_PREFIX}/jdk8
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/fop", @env)
  end
end
