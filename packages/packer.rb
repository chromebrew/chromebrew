require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.16.1'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'dfb61912e59912f7d559a1f2b7bdf9fad702ae0a86226d87a8cee04a981a08b7',
     armv7l: 'dfb61912e59912f7d559a1f2b7bdf9fad702ae0a86226d87a8cee04a981a08b7',
       i686: '7d1c701d0e178a4b16157350bb7323e278a67d623a32d230b9afd04b65c5c6f2',
     x86_64: 'af38a9e93e4ed1b9ca68206ae969c64c300c82a3dde46a780dfa629f0867f651'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
