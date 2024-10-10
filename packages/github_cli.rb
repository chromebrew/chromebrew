require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.58.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '76d661266f720e18287acce689f5bf1b9eb59838fdf3f9667cc0d6a1d28b4ac9',
     armv7l: '76d661266f720e18287acce689f5bf1b9eb59838fdf3f9667cc0d6a1d28b4ac9',
       i686: 'c10f927775194d9d316fe03c1f97857d676d7ec0d7e2ae71e337a9f9f6aef1fb',
     x86_64: '84feae3d143bc360ea1004b474f124c8cfd75363a5e197d3ce63fe23d9f3a2ea'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
