require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.16.2'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '5985e8a757d3814b5eddb9b9c93b45a2e48bf1e509925a0e43030c17d55c201a',
     armv7l: '5985e8a757d3814b5eddb9b9c93b45a2e48bf1e509925a0e43030c17d55c201a',
       i686: 'ef50a456a17681dac22eef1224ee088dfd22139b9f89e0d661c982be46c467b9',
     x86_64: 'abbfe0cf74985084112659b53e3565f264f70a20914c3b7c4f789f54f61c2414'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
