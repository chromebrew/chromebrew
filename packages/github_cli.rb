require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.66.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'c6f6a7539dca0d48e202c42cf4b932425fe3f191d08eb375a63f2039af4d81e8',
     armv7l: 'c6f6a7539dca0d48e202c42cf4b932425fe3f191d08eb375a63f2039af4d81e8',
       i686: 'a9a774ee4b747e06a962744bb3be0846550e1d7e0ba8b6e7e4fa62cddc8a67e9',
     x86_64: '387b4e9a717ddf2efa8426a774f14463bf64e41fb7bec3463c737cf5413e5a79'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
