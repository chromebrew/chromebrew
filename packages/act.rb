require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.84'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '6d4a5886b76fe030ac0fbf3d69f4ff8d06f8d6cd0dc4ea8d02edb459ede301a4',
     armv7l: '6d4a5886b76fe030ac0fbf3d69f4ff8d06f8d6cd0dc4ea8d02edb459ede301a4',
       i686: '979350138ee837892de07108fca73638da5be0e0fbbe6f089e42c44d417f2140',
     x86_64: '19d4525fb0d80ff50bd3252d3fa47ee1265a331fe4c39249ac65347e527e16e2'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
