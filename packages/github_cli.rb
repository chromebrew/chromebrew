require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.52.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'e5721ce20fab3676814b06119367a270d4e5b23e7a2f995aaed2ea9ccdc3e9f4',
     armv7l: 'e5721ce20fab3676814b06119367a270d4e5b23e7a2f995aaed2ea9ccdc3e9f4',
       i686: '1e4896c404bb626a694f853b335b8778bdf07996bd10faf3aa4876cd2102ed91',
     x86_64: '3ea6ed8b2585f406a064cecd7e1501e58f56c8e7ca764ae1f3483d1b8ed68826'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
