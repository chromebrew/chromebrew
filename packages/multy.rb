require 'package'

class Multy < Package
  description 'Easily deploy multi cloud infrastructure.'
  homepage 'https://multy.dev/'
  version '1.0.1'
  license 'Apache-2.0'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/multycloud/multy/releases/download/v#{version}/multy-linux-amd64.tar.gz",
      i686: "https://github.com/multycloud/multy/releases/download/v#{version}/multy-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5',
      i686: '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5'
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
