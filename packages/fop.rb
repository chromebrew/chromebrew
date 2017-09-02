require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.2'
  source_url 'http://apache.forsale.plus/xmlgraphics/fop/binaries/fop-2.2-bin.tar.gz'
  source_sha256 '9dc1f9d1cb9acf5b3352116924c0b7678a88703b1214d537bc027c6867ec4dfe'

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
    puts
    puts "To complete the installation, set the environment variable as follows:".lightblue
    puts "echo 'export JAVA_HOME=#{CREW_LIB_PREFIX}/jdk8' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
