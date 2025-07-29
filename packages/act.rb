require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.79'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'db412f59118325c3a51447cec997c3618bdbe5bdb437b800cd72bc75aeba0958',
     armv7l: 'db412f59118325c3a51447cec997c3618bdbe5bdb437b800cd72bc75aeba0958',
       i686: 'd8f881da479c7a0180e4e7a9073a30fbe62a1d08e1941f2bc17dbba25918b0f3',
     x86_64: 'b4c14df1a6e713a63e8e153534091a2e0d93a73538da301bd3aaa3c1f2a6f571'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
