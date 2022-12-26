require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.34'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/nektos/act/releases/download/v0.2.34/act_Linux_armv7.tar.gz',
     armv7l: 'https://github.com/nektos/act/releases/download/v0.2.34/act_Linux_armv7.tar.gz',
       i686: 'https://github.com/nektos/act/releases/download/v0.2.34/act_Linux_i386.tar.gz',
     x86_64: 'https://github.com/nektos/act/releases/download/v0.2.34/act_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '4ed0b6af2f7dd0f744cc88b9adcbede9522a515510f4169724a251f9da6f96c3',
     armv7l: '4ed0b6af2f7dd0f744cc88b9adcbede9522a515510f4169724a251f9da6f96c3',
       i686: 'eeaa3219a22f08f8a2d1f684aed5ad8abf5b00f264926fbd0ef9c69de507ecf9',
     x86_64: 'b8429964db6f265ddc1834802acd3ffb891249165edd6a9228e94c3d0cbbd8c9'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
