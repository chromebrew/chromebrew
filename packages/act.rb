require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.82'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'b63f2cee0258555052f990ffdfd4399be1c9c95f7cd380ee8e74341422e14b28',
     armv7l: 'b63f2cee0258555052f990ffdfd4399be1c9c95f7cd380ee8e74341422e14b28',
       i686: '4fefdfe2160cc2192874575eb7daf29425c52e27f425258376b001dc1c818ccb',
     x86_64: '76645c0bbe4bb69a8f0ba3caefa681b2f4c04babd4679c67861af9a276a3561f'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
