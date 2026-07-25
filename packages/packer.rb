require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.16.0'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'ea4f55fe0a2b38d57c8261d7a0999b17d4fcea03306b7781f52d09d99de26347',
     armv7l: 'ea4f55fe0a2b38d57c8261d7a0999b17d4fcea03306b7781f52d09d99de26347',
       i686: '334461d39381edad194e27c38d345e9950f18305029dfaed15f5f1d695fa2ab7',
     x86_64: '5edcd14ab59b535040c512dbecd6ec9ef976a000b073c19d93e4c431c948581e'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
