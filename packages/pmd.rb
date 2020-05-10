require 'package'

class Pmd < Package
  description 'An extensible cross-language static code analyzer.'
  homepage 'https://pmd.github.io/'
  version '5.8.1'
  compatibility 'all'
  source_url 'https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-5.8.1.zip'
  source_sha256 '2d854e30717b66e253213f36d4bcd202b83b180ea427836797d13a857c19a6b4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-5.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-5.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-5.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-5.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3a67cbb0aa75d9b5bb6b30d54029cf8598810045e10cc5b8622c52ae0f0f67a4',
     armv7l: '3a67cbb0aa75d9b5bb6b30d54029cf8598810045e10cc5b8622c52ae0f0f67a4',
       i686: '8271fa0b8d53652830d7d791dbc859d298f1dc573cf956c6029e5f52edd15435',
     x86_64: '0faf4b05cbaad158d8776b7229e85fce484e9c9d1245c4977647bdb653c2e1b8',
  })

  depends_on 'jdk8'
  depends_on 'unzip'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > cpd"
      system "echo 'PWD=$(pwd)' >> cpd"
      system "echo 'cd #{CREW_LIB_PREFIX}/pmd' >> cpd"
      system "echo 'bin/run.sh cpd \"$@\"' >> cpd"
      system "echo 'cd $PWD' >> cpd"
      system "chmod +x cpd"
      system "echo '#!/bin/bash' > pmd"
      system "echo 'PWD=$(pwd)' >> pmd"
      system "echo 'cd #{CREW_LIB_PREFIX}/pmd' >> pmd"
      system "echo 'bin/run.sh pmd \"$@\"' >> pmd"
      system "echo 'cd $PWD' >> pmd"
      system "chmod +x pmd"
    end
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/pmd"
    system "cp -r . #{CREW_DEST_LIB_PREFIX}/pmd"
  end
end
