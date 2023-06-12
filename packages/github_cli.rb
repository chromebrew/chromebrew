require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.30.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.30.0/gh_2.30.0_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.30.0/gh_2.30.0_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.30.0/gh_2.30.0_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.30.0/gh_2.30.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '472424e5739fb626921423f04cc30aed14605eb019ec860104351baf1a7307d4',
     armv7l: '472424e5739fb626921423f04cc30aed14605eb019ec860104351baf1a7307d4',
       i686: 'b44c30f3662c27f60d64d420f4c8fe62d5670592de894faa245405c710a07e1c',
     x86_64: '5aee45bd42a27f5be309373c326e45cbcc7f04591b1798581a3094af767225b7'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX.to_s
  end
end
