require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.86'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '0d8cf16c130642f4a5749f82825ccfbc0175b49519976a48220c462d4e4a05ec',
     armv7l: '0d8cf16c130642f4a5749f82825ccfbc0175b49519976a48220c462d4e4a05ec',
       i686: '6cecfbd0f425f65f6d3bfa13d4cac76133302fb1c2b3ee12419b8c048223a506',
     x86_64: 'f83f11968f19c43bf439d18b279247eb9c95df5eb984e6eebf8aa0e433b270ba'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
