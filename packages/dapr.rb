require 'package'

class Dapr < Package
  description 'Command-line tools for Dapr.'
  homepage 'https://dapr.io/'
  version '1.19.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_arm.tar.gz",
     armv7l: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_arm.tar.gz",
     x86_64: "https://github.com/dapr/cli/releases/download/v#{version}/dapr_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '3a97749da2011f47b16d1f4f4fbdbee2b66437746bd32a97743855b622923967',
     armv7l: '3a97749da2011f47b16d1f4f4fbdbee2b66437746bd32a97743855b622923967',
     x86_64: '7fee19c8aa58c7b43af840c5c272097009855ab2c8d69ae055d3d9c0fab56b7b'
  })

  def self.install
    FileUtils.install 'dapr', "#{CREW_DEST_PREFIX}/bin/dapr", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dapr -h' to get started.\n"
  end
end
