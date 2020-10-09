require 'package'

class Pmd < Package
  description 'An extensible cross-language static code analyzer.'
  homepage 'https://pmd.github.io/'
  version '6.28.0'
  compatibility 'all'
  source_url 'https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.28.0/pmd-bin-6.28.0.zip'
  source_sha256 '9a19365f2e107ae801b39be04c5c03cdca2d352c450faac639a6dd95b5c3ab0c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-6.28.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-6.28.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-6.28.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pmd-6.28.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ffa1b5c562929b74903a42bb8246203b6b1a09a156031e25522991bb25eea51',
     armv7l: '3ffa1b5c562929b74903a42bb8246203b6b1a09a156031e25522991bb25eea51',
       i686: '8002bc791ac2751dca2c557b248a3d52eff48c5ad04d8ad4320fc4b19a88a230',
     x86_64: 'a9595a5dc740d9f952526817488a86bca488ec06daac8b990b724eca45459629',
  })

  depends_on 'jdk8'
  depends_on 'unzip'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd "#{CREW_DEST_PREFIX}/bin" do
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
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/pmd"
    FileUtils.cp_r '.', "#{CREW_DEST_LIB_PREFIX}/pmd"
  end
end
