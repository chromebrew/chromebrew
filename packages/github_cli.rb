require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.27.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.27.0/gh_2.27.0_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.27.0/gh_2.27.0_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.27.0/gh_2.27.0_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.27.0/gh_2.27.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '2289fa1537bbf424947e1643f4616fb1c6b7e011b43b25e2e72af1b1e4d74f97',
     armv7l: '2289fa1537bbf424947e1643f4616fb1c6b7e011b43b25e2e72af1b1e4d74f97',
       i686: '5139f84c5e4a51a3b29798797091c2b9f69ee0bf3ecacc30d69f7caf92606c86',
     x86_64: 'a3e2987e49ede4e90e0192f64c5e1480d6a1ee3196d51a4fcfbe0ccd0a627747'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX.to_s
  end
end
