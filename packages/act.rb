require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.94'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'fb6166aca298b3914f7bb73837dbefec090e304e0eeeee778b55458aaf71c390',
     armv7l: 'fb6166aca298b3914f7bb73837dbefec090e304e0eeeee778b55458aaf71c390',
       i686: '7ee7467c5e06db7f1893b8dc40e769976d3067db35e75dbbf43d1ea9292d7452',
     x86_64: '33e6748e3c07affb6855f19fb7a28bc6c344c1d0888fae0564e6d34d4a71915a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
