require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.78'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '03edf055f000acb6cbc6695a1408e3ae7a56f5e5373cc00277a559e168eb1bac',
     armv7l: '03edf055f000acb6cbc6695a1408e3ae7a56f5e5373cc00277a559e168eb1bac',
       i686: '5e2d35c411a43dfc0f1969a229ffccfebf2b21e4cb1328b4c8df6600698b1b97',
     x86_64: '7e90d7b1d61aa518e32f348d456fa690a06a5170aa59b18b8da507e3029c9845'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
