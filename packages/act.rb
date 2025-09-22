require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.81'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'a1c61b30765f23989b4a2c8ad9c5fe50f309508186a767ee12feb1ca3b68b5af',
     armv7l: 'a1c61b30765f23989b4a2c8ad9c5fe50f309508186a767ee12feb1ca3b68b5af',
       i686: '90e51c7c80e187f5dc3b048366252333aacfd427540197796e581cfb22515332',
     x86_64: '2198d2b3b6f5751751c829475255d99f9558d0043970b4a043e3af16715fa0cf'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
