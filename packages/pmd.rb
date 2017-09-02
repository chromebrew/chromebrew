require 'package'

class Pmd < Package
  description 'An extensible cross-language static code analyzer.'
  homepage 'https://pmd.github.io/'
  version '5.8.1'
  source_url 'https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-5.8.1.zip'
  source_sha256 '2d854e30717b66e253213f36d4bcd202b83b180ea427836797d13a857c19a6b4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'unzip'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/pmd"
    system "cp -r . #{CREW_DEST_LIB_PREFIX}/pmd"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "ln -s #{CREW_LIB_PREFIX}/pmd/bin/run.sh pmd"
    end
  end
end
