require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.15.4'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'b4830f7963fc34de7281e1d3a6e5dbb1d492334237f9247ec8dd2b13c552a409',
     armv7l: 'b4830f7963fc34de7281e1d3a6e5dbb1d492334237f9247ec8dd2b13c552a409',
       i686: '65ae4f04bb4ec5da807920030de3ea8a5e78a14c65ee37c00ba30c9fb22f961f',
     x86_64: '15f97a6a99645c7d5308c609973b5280837b38e112beac413ccbce80da927cf1'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
