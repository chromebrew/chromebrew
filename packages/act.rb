require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.72'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'c4958be9b6d9f9d009efd7cfaeffef5958db4276def0b47b3ffb63295cabac31',
     armv7l: 'c4958be9b6d9f9d009efd7cfaeffef5958db4276def0b47b3ffb63295cabac31',
       i686: '1d90876d166cd78bcd0f4f563efa2ea2d1ab561535f0e6025579f8e6e4138bc4',
     x86_64: '8314db77371828dea9a517d5a64fecc541fd74e227c1cf399756f27e6f54c75b'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
