require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.29.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.29.0/gh_2.29.0_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.29.0/gh_2.29.0_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.29.0/gh_2.29.0_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.29.0/gh_2.29.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '193bc95e024a3e53a3d3850fc2e619ddc9ca1bf3de384abb0f15e68ff1aaefbd',
     armv7l: '193bc95e024a3e53a3d3850fc2e619ddc9ca1bf3de384abb0f15e68ff1aaefbd',
       i686: '99c8b66f18b1d5e71950f2e04f8e41f466316179f838816d73c4c94fc632a7a7',
     x86_64: '9fe05f43a11a7bf8eacf731422452d1997e6708d4160ef0efcb13c103320390e'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX.to_s
  end
end
