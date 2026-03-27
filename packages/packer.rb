require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.15.1'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'b2f3b0d138f78c4ced18f63e92e78944f71466b2c23ee2c082d2dacf1f76391f',
     armv7l: 'b2f3b0d138f78c4ced18f63e92e78944f71466b2c23ee2c082d2dacf1f76391f',
       i686: 'c6a89998d0f87d60a43c110ba22c57d270b3a083ac480f9e0579b042ff15d2bc',
     x86_64: '648d704bec73805a5508ed612185a9e5858ca7d57b730b88b1a54c3af3a91f5f'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
