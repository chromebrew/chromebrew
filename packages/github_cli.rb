require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.44.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.44.1/gh_2.44.1_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.44.1/gh_2.44.1_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.44.1/gh_2.44.1_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.44.1/gh_2.44.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'e50452bd849204e81856e3731c327d0c621e5a2215c59bb3223b4758726aeb20',
     armv7l: 'e50452bd849204e81856e3731c327d0c621e5a2215c59bb3223b4758726aeb20',
       i686: '96395ee7b79ce5054ecc1f42dc907d7d34d2e866cf6a65a5a51dcbc828310b50',
     x86_64: 'f11eefb646768e3f53e2185f6d3b01b4cb02112c2c60e65a4b5875150287ff97'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
