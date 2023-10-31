require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.37.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.37.0/gh_2.37.0_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.37.0/gh_2.37.0_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.37.0/gh_2.37.0_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.37.0/gh_2.37.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '0c7f8c6cf37acc75fa4366dbd89627f3c29615e7e22bb5dd83d4f20f32d49d41',
     armv7l: '0c7f8c6cf37acc75fa4366dbd89627f3c29615e7e22bb5dd83d4f20f32d49d41',
       i686: 'e87926c8444a436fbd5c03723ff23d0a6a89c01e7c9799feadc0142b744538f4',
     x86_64: 'a1d79712c20af6fe36e388e762bda60c3fc8fb4af2f0cff666143f2c7d3baa88'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX.to_s
  end
end
