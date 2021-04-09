require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.6-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/xmlgraphics/fop/binaries/fop-2.6-bin.tar.gz'
  source_sha256 'ccfd7a1d4e5a04e76723946efa1147ffa9a8715ce2b58d2a27085a8e744520f8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5b7a73cd366557240852ea2ec1dc75d2f75d2b0b47c6d5634c2995aba1de79c0',
     armv7l: '5b7a73cd366557240852ea2ec1dc75d2f75d2b0b47c6d5634c2995aba1de79c0',
       i686: '6b830403f1596aba2a77856a892913b7b0776f2cb78cc62c1d867d8ad394db5a',
     x86_64: '489c9c4000771c944e54a70e01015e0d5e62acbf1d32cea7c41eb481b506ed1c'
  })

  depends_on 'jdk8'

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
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/fop", @fopenv)
  end
end
