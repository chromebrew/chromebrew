require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.74'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'a303564e1af2ae49d43808910db6bf8bc128a7d2e70e359ca14825fa2960454d',
     armv7l: 'a303564e1af2ae49d43808910db6bf8bc128a7d2e70e359ca14825fa2960454d',
       i686: 'f496c10f5f64bb46af8c07907316b22d0e0eb8de2cd5033b2abb6e23818d7513',
     x86_64: '7512b40671e073a011470e216eb2256d1b3ae37b5970d53dc23b29375ffb90f6'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
