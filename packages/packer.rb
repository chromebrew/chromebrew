require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.15.3'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'ced0c4d91f2642affb8188459a167aafd7d62e660b59db9e7fa9bdcfdb895324',
     armv7l: 'ced0c4d91f2642affb8188459a167aafd7d62e660b59db9e7fa9bdcfdb895324',
       i686: '080c986c5e441197750ed1a6d5b398b558601218793b4bdcb16a040b9ecf0f05',
     x86_64: '9ed712c9a8f223c7985d7d21c6b65744bf1c66b8aca333232b96f5ae3fd9c90d'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
