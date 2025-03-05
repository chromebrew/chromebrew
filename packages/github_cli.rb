require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.68.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '6dfd3ed341b1ea08fcff55436ee50bc1c878b8c5fda9a1254e8653da9bd15c65',
     armv7l: '6dfd3ed341b1ea08fcff55436ee50bc1c878b8c5fda9a1254e8653da9bd15c65',
       i686: '6758f00fd2c04771ab9d1c3c1e18cad6eaafe10c09b85a7744d9e7b53c1d372e',
     x86_64: 'dcd944ecd9905b62fbaf3fe3703af7d6f9a33bc8c36d8603af55cab0d3f67879'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
