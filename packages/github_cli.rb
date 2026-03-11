require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.88.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '07aa6a4d0fc3eec4cdb2319a9b3c9fe5fe53b8ad0be9dc45a75569be7014e409',
     armv7l: '07aa6a4d0fc3eec4cdb2319a9b3c9fe5fe53b8ad0be9dc45a75569be7014e409',
       i686: '1b23149b2aaad5af6b31f3b8be8cae3747b0b2dec746ce1b3f03285b30831c66',
     x86_64: '4d268420ad31846a807e3012ac4b6547df662777e7776fa7f4c55ce062e15b15'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
