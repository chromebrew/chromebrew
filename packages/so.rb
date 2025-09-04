require 'package'

class So < Package
  description 'A terminal interface for Stack Overflow.'
  homepage 'https://github.com/samtay/so'
  version '0.4.10'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/samtay/so/releases/download/v#{version}/so-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/samtay/so/releases/download/v#{version}/so-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/samtay/so/releases/download/v#{version}/so-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'f2836ef57869425d487a3d788a70ccb740c920550bdef197b5e7d0f56773d88c',
     armv7l: 'f2836ef57869425d487a3d788a70ccb740c920550bdef197b5e7d0f56773d88c',
     x86_64: 'b94ca89f01758dce4d763d78f5ec1b400c4e2aa64975b6d267bd635a519bcb37'
  })

  def self.install
    FileUtils.install 'so', "#{CREW_DEST_PREFIX}/bin/so", mode: 0o755
  end
end
