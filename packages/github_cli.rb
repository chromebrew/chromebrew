require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.94.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'de14a3c71e6af90794f1abd5a060f2d4b2ee3d8c854d7f6bf94a97158bc2e653',
     armv7l: 'de14a3c71e6af90794f1abd5a060f2d4b2ee3d8c854d7f6bf94a97158bc2e653',
       i686: '0b5402084552851a31bd1b48e1c78b7a92301dc097752eed5bc5a202d6578096',
     x86_64: 'a757f1ba6db18f4de8cbadb244843a5f89bc75b5e7c6fc127d2bd77fbd12ed62'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
