require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.77'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '9258c694a4de282c7167352b4fc7d38a03b2665e8da34584895104ba255d22e6',
     armv7l: '9258c694a4de282c7167352b4fc7d38a03b2665e8da34584895104ba255d22e6',
       i686: 'ed93b9e2eda9e31e6471da4bc77ad339d9a38a5efedf723e0ae470ac8f538ed7',
     x86_64: 'be48669e49cfed33d36f4c34c4fce2722c8261a47b174d66cee751a219e75d8e'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
