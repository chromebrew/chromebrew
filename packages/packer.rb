require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.14.3'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '0676cbfb8f3a666c8b3c38e4f5d58db54e5ee70ebd7baf725df7f0cea2bb6fd9',
     armv7l: '0676cbfb8f3a666c8b3c38e4f5d58db54e5ee70ebd7baf725df7f0cea2bb6fd9',
       i686: 'b9f3e49aa5a31a4fe0cab45d284e05b7a7b9d5532400d6cd6e5ad604f814649f',
     x86_64: '95041cc0a30f05d5583be26a7c0b715f488e461418ce0c5d88ba204cb092bef1'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
