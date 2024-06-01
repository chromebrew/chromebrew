require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.50.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.50.0/gh_2.50.0_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.50.0/gh_2.50.0_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.50.0/gh_2.50.0_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.50.0/gh_2.50.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'adc010fdc4139d12550f692b448232556b87dc35e16dea7bace5f7b6dab458e5',
     armv7l: 'adc010fdc4139d12550f692b448232556b87dc35e16dea7bace5f7b6dab458e5',
       i686: '634bfb463f2f105d16b0eb3cae3eaff3ce6463d9230aeccea5305347dd32a459',
     x86_64: '7f9795b3ce99351a1bfc6ea3b09b7363cb1eccca19978a046bcb477839efab82'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
