require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.54.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'cd53809273ad6011fdd98e0244c5c2276b15f3dd1294e4715627ebd4f9c6e0f1',
     armv7l: 'cd53809273ad6011fdd98e0244c5c2276b15f3dd1294e4715627ebd4f9c6e0f1',
       i686: '5675606eaa8ab683477a137f73dad7f25e4e0efb2e4e22538d63d68ac764ec3d',
     x86_64: 'c4441b2acfb63feb5fc37a346b0a0a66080d657397f1eb81e3025961dcb06dd3'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
