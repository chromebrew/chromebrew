require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.43.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.43.1/gh_2.43.1_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.43.1/gh_2.43.1_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.43.1/gh_2.43.1_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.43.1/gh_2.43.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '47e6757e79db4e660f8210c0cc8882c4d42bcccff598f035ea13f3035db6bacc',
     armv7l: '47e6757e79db4e660f8210c0cc8882c4d42bcccff598f035ea13f3035db6bacc',
       i686: '053d00454d99d6dddd69de1a3f72f8cfe1cac7676baee3759399dc579ebcaea6',
     x86_64: '0935fb1c783f65a0d43ebe4988dd117b27355704e230c386d9fd30774d729111'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
