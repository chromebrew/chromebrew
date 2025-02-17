require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.67.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'a0d6aaaf85f7cc9ce1ed4eaacee6a5ae942bcb9772a966cc88c32ac74d625198',
     armv7l: 'a0d6aaaf85f7cc9ce1ed4eaacee6a5ae942bcb9772a966cc88c32ac74d625198',
       i686: '86ac88c2681cbb7d72521ccbb1316c88760201d77b34209256c2b45c485f3d1b',
     x86_64: 'd77623479bec017ef8eebadfefc785bafd4658343b3eb6d3f3e26fd5e11368d5'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
