require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.88.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '53eed76f45e4ab9d67e3937306477703a14e24d5e0c5a69d6e9bdeb0c5ba59f8',
     armv7l: '53eed76f45e4ab9d67e3937306477703a14e24d5e0c5a69d6e9bdeb0c5ba59f8',
       i686: '273b5ca7fa6fc6f6ac8e0e1bd91f012726c8d479370f786c47e3a4da3c47cc8d',
     x86_64: '36352a993b97e9758793cdb87f9ba674bd6d88c914488e122be78a1962203803'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
