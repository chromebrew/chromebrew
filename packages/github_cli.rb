require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.31.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.31.0/gh_2.31.0_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.31.0/gh_2.31.0_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.31.0/gh_2.31.0_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.31.0/gh_2.31.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '8ca0f926fa7c7090199f0e87c3d22e8167f4f2892c1b77dcf041ce50fd6423a0',
     armv7l: '8ca0f926fa7c7090199f0e87c3d22e8167f4f2892c1b77dcf041ce50fd6423a0',
       i686: '10a734127afeb4a5fc940d3023175130d3f432b14591eb8a2a24d8325c8ed803',
     x86_64: 'eec349e43803759d3d7a138d214ae983a3bebebd8e6dd0ec0ff1eea7bdd823e7'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX.to_s
  end
end
