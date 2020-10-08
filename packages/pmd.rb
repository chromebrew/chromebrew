require 'package'

class Pmd < Package
  description 'An extensible cross-language static code analyzer.'
  homepage 'https://pmd.github.io/'
  version '6.28.0'
  compatibility 'all'
  source_url 'https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-6.28.0.zip'
  source_sha256 '71912ee24f28b3607f6b3aabfc7cab13bbff84d43a319a78a05f0eca7c4ba4dc'

  binary_url ({
    
  })
  binary_sha256 ({
    
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
