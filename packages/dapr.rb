require 'package'

class Dapr < Package
  description 'Command-line tools for Dapr.'
  homepage 'https://dapr.io/'
  version '1.18.3'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_arm.tar.gz",
     armv7l: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_arm.tar.gz",
     x86_64: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '3a66eec26751a5f4fdf0ad25e0f2c24041a75597bf7574701b9a640c2786831c',
     armv7l: '3a66eec26751a5f4fdf0ad25e0f2c24041a75597bf7574701b9a640c2786831c',
     x86_64: 'b0dd9a7672cce23995bb3d80637ac354a18c2dc74f1cb6ee564cc6b5da6acf51'
  })

  def self.install
    FileUtils.install 'dapr', "#{CREW_DEST_PREFIX}/bin/dapr", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dapr -h' to get started.\n"
  end
end
