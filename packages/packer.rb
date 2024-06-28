require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.11.0'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '644ff27386993ef09b29169c383b70c0c92aef6bce53bdd9f87b945c4a6a31bb',
     armv7l: '644ff27386993ef09b29169c383b70c0c92aef6bce53bdd9f87b945c4a6a31bb',
       i686: 'b3f51d82341c155c520d530178ffdf5cfe48cd001cf9a760ece11e7813132ca0',
     x86_64: 'dcac06a4c671bbb71e916da5abe947ebf4d6aa35c197e21c7c7b1d68cb8b7cad'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
