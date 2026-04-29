require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.92.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '341d86af867f2622c03cdfda103826170f4851e59966bfeec70bb7c13745c1a4',
     armv7l: '341d86af867f2622c03cdfda103826170f4851e59966bfeec70bb7c13745c1a4',
       i686: '65320dc8465c424fd3ae0a114a9753e815db89436ee2d0921641f30705af691d',
     x86_64: 'b57848131bdf0c229cd35e1f2a51aa718199858b2e728410b37e89a428943ec4'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
