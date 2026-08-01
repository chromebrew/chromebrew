require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.97.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '83698de1d91d201cc3b9d9b0beb346c221cadb53a68fb82f741ef0a0efc4502c',
     armv7l: '83698de1d91d201cc3b9d9b0beb346c221cadb53a68fb82f741ef0a0efc4502c',
       i686: 'ba556b1061cfc89fee62d1e59dfacd2ea646d8c3bb41cbef909ec6ed27071512',
     x86_64: 'a2c9b8497e1f85b1ad0dfcb78b5a622e098801b8e461e459e88e1ee12f018112'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
