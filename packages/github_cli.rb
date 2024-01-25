require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.42.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.42.1/gh_2.42.1_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.42.1/gh_2.42.1_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.42.1/gh_2.42.1_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.42.1/gh_2.42.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'fd57734c176c8622cc071737709186c77bb650bb97583bc3234bcc7130dd0461',
     armv7l: 'fd57734c176c8622cc071737709186c77bb650bb97583bc3234bcc7130dd0461',
       i686: '97b7a8ccbfc77f4dbde041572301917e0114df557701a9d0a490c922ae7399f3',
     x86_64: 'c82c865545549131f284bf4df73c03c63971a87286fce5ab5d11c9dc0cee2cbb'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
