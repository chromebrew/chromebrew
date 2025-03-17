require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.68.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'ac7de4f2b8d692580a44cef00d44a37429c9b75e2c6f34fe7ce5e92a1c539ee7',
     armv7l: 'ac7de4f2b8d692580a44cef00d44a37429c9b75e2c6f34fe7ce5e92a1c539ee7',
       i686: 'cd8081943bd3b2af07e1e5bc1e3a28c42c899e66a760d72a47049ba6f269b33e',
     x86_64: 'b4f533bf21d1fc0750976b4755e479ae3f59bfc42c9c22dfb0c0c5491ab1e152'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
