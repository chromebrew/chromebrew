require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.39.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.39.1/gh_2.39.1_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.39.1/gh_2.39.1_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.39.1/gh_2.39.1_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.39.1/gh_2.39.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '71388fa95e9600bfc33b72df6037ba5cef2323c0b5aa3a20875c1a2551b2e8dc',
     armv7l: '71388fa95e9600bfc33b72df6037ba5cef2323c0b5aa3a20875c1a2551b2e8dc',
       i686: '892f97d5d2b42eb95dc37d1851725564ec26f4c3b7f96bfe6c76d58ed1e12fa8',
     x86_64: '18a1bc97eb72305ff20e965d3c67aee7e1ac607fabc6251c7374226d8c41422b'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
