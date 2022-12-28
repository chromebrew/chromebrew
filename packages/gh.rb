require 'package'

class Gh < Package
  description 'GitHub’s official command line tool'
  homepage 'https://cli.github.com/'
  version '2.21.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.21.1/gh_2.21.1_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.21.1/gh_2.21.1_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.21.1/gh_2.21.1_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.21.1/gh_2.21.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '4218c205359a8f4b94e56419d6383301ae43265c4217f6567f054cf76aac9490',
     armv7l: '4218c205359a8f4b94e56419d6383301ae43265c4217f6567f054cf76aac9490',
       i686: '562d304de4e28029159fd805c755c2f7f204d03027bd65ea4ca02bce58e24c2d',
     x86_64: '0c0ab559721d2ff05df9d64fcdaca4f8f0b76d177832379116bd5c4d032fea88'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.mv 'share', "#{CREW_DEST_PREFIX}"
  end
end
