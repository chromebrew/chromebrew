require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.59.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '3a48706879737bbc2404062f0a9921ffd7426deb5c541c8869abe0f2bcf43ff9',
     armv7l: '3a48706879737bbc2404062f0a9921ffd7426deb5c541c8869abe0f2bcf43ff9',
       i686: 'ac08191ed067cc504468726ee08efa755b060d46fbd31fe641f50b1094628aca',
     x86_64: '2ce2e480e3c3f7ca0af83418d3ebaeedacee135dbac94bd946d7d84edabcdb64'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
