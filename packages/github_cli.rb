require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.60.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '9ca62426c20b6cdd5e32ffe5ae6fca75edea14645bc6de0e853025eadd3544a6',
     armv7l: '9ca62426c20b6cdd5e32ffe5ae6fca75edea14645bc6de0e853025eadd3544a6',
       i686: '9f83869ca7b11d014481c73afbebea6ea238c8585684cec7389eca03513636cb',
     x86_64: 'dfcd9926de38a797e88e604c3111ecf9ddf13c524706712b2b0d2e2fc4a6ed7f'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
