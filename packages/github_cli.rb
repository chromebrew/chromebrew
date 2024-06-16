require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.51.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'a9943b3ea1907fc7b4d5bca4a2c2fa81722b02bbdaf11725516b2b0cfc78c449',
     armv7l: 'a9943b3ea1907fc7b4d5bca4a2c2fa81722b02bbdaf11725516b2b0cfc78c449',
       i686: 'dda319dc8c0c62bfbb238c61dafd3da0db2ea08a94c6ada3111099bc808ecaf5',
     x86_64: 'd7725fb2a643ca024edf5b4e2f2cca0431a404bbc2e251086ffca2b25e37be11'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
