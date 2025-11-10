require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.14.2'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '1bca6b645d2f4e5968b77f6b2ccc06e9ab4f38eb1453116ee6542402068bdb0c',
     armv7l: '1bca6b645d2f4e5968b77f6b2ccc06e9ab4f38eb1453116ee6542402068bdb0c',
       i686: '52c6bc04da164dbba135aa974f3a36bb662091187bc39997b1e548f589854d04',
     x86_64: 'cfefdea4ac580eba7b254ef34d25b756d4961741004e3e701a1476594d13e64a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
