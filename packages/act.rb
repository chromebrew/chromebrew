require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.98'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '4c4a38e20e6d78bbd5b07ae961a62ed6c74fb300e3717f72e06359b32bee69a9',
     armv7l: '4c4a38e20e6d78bbd5b07ae961a62ed6c74fb300e3717f72e06359b32bee69a9',
       i686: '38d829e9d6541a9466197019ff8f540b7213be01d57ceb056c04c48c81230abe',
     x86_64: 'd3344bd0810c04b000d2444030b08c90ab9fbf905bbe2c3e26298be00c620d65'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
