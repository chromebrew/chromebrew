require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.75'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '03bdf204ec2c6530a472c00c71e32a4221a26817a9c77b9b9f5c8d2ff94de688',
     armv7l: '03bdf204ec2c6530a472c00c71e32a4221a26817a9c77b9b9f5c8d2ff94de688',
       i686: '1e9b7f610e36548a250120e21a5b1d1dc343db070ba78b2b79737858fda58d62',
     x86_64: '4856dd522006d702acc8c72c3265752b1ab2be2dbd5580184aba19cec91f2651'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
