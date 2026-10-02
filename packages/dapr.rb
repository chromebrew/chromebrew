require 'package'

class Dapr < Package
  description 'Command-line tools for Dapr.'
  homepage 'https://dapr.io/'
  version '1.18.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_arm.tar.gz",
     armv7l: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_arm.tar.gz",
     x86_64: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '5210be8e55f64d30fccfed1017ed439f0662a8612e1024bb43cb289039975762',
     armv7l: '5210be8e55f64d30fccfed1017ed439f0662a8612e1024bb43cb289039975762',
     x86_64: 'ccfff008fd16f50096a9192ad56697ac7052e3add6fa0a07789d87b4c4df8c40'
  })

  def self.install
    FileUtils.install 'dapr', "#{CREW_DEST_PREFIX}/bin/dapr", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dapr -h' to get started.\n"
  end
end
