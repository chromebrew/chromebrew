require 'package'

class Multy < Package
  description 'Easily deploy multi cloud infrastructure.'
  homepage 'https://multy.dev/'
  version '0.1.57'
  license 'Apache-2.0'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/multycloud/multy/releases/download/v#{version}/multy-linux-amd64.tar.gz",
      i686: "https://github.com/multycloud/multy/releases/download/v#{version}/multy-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: '348fe997f026f3734a96f61c5198fe2ad10a9810dd71ab7c6971a63bf1c013fe',
      i686: '2913857363d20d66c9a9c21f0a0cd498611e745f6d6121ebd665de833ad7118c'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'multy', "#{CREW_DEST_PREFIX}/bin/multy", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'multy list --help' to get started.\n".lightblue
  end
end
