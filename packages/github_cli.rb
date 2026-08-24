require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.98.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '2c1706b6ff1f10bf93a0b370bc61e45f5e1fd78379361f414c5ac05bc5bf75d3',
     armv7l: '2c1706b6ff1f10bf93a0b370bc61e45f5e1fd78379361f414c5ac05bc5bf75d3',
       i686: '11e9594b2c9eb501a064dcb66e7befebe3e8c2d79b606dabaa6935c5c8cd802f',
     x86_64: '3b8ac6b30336802fc1a858d7c084e11cdf24ac1a761ca90b68022d7d729208de'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
