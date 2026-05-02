require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.88'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '874914e25e017c122bc5401e4c39dc95aa1bfe3c389264e78c57887d2e8ead38',
     armv7l: '874914e25e017c122bc5401e4c39dc95aa1bfe3c389264e78c57887d2e8ead38',
       i686: '27c992a07546c03f5c7bea3126ad44e6deef0eb0560ed21489e499839ea1e360',
     x86_64: '1eb9996682dfcc053ac8f3f90f2ec50376f0cdfc229712d82da03d673c63a2b3'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
