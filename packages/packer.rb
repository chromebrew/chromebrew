require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.16.3'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '99c93e1038dcef631f237451e1be9586312d62567ff5988fc98f0c0f0a5b9b88',
     armv7l: '99c93e1038dcef631f237451e1be9586312d62567ff5988fc98f0c0f0a5b9b88',
       i686: 'fb06c0cabb95e5ee53a8e9a63eee84a063d55a8185fd06e9d69be560d0312ea1',
     x86_64: '9d625866a239583652e6ea210234abfd6416a27459cd482e5a03a845b9726d6c'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
