require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.80'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '2777add130cbd413ea1ec4d2a76f8bf1e38fc3f6467161eb86fffc00f97e3439',
     armv7l: '2777add130cbd413ea1ec4d2a76f8bf1e38fc3f6467161eb86fffc00f97e3439',
       i686: 'b7d396ee90f69fc6f8352d74e0c5fbf449d1d2b60d4c207e50195bf363d60b60',
     x86_64: 'c445f20b3caa1fefedb063c187f26f1466d4e37687d34f1d11d40031d0d005fe'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
