require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.7.10'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: 'https://releases.hashicorp.com/packer/1.7.10/packer_1.7.10_linux_arm.zip',
     armv7l: 'https://releases.hashicorp.com/packer/1.7.10/packer_1.7.10_linux_arm.zip',
       i686: 'https://releases.hashicorp.com/packer/1.7.10/packer_1.7.10_linux_386.zip',
     x86_64: 'https://releases.hashicorp.com/packer/1.7.10/packer_1.7.10_linux_amd64.zip'
  })
  source_sha256({
    aarch64: '6da48ac438997cc824f8f6c0be75caceebcc8bcebc7f1c54d1a62699fc388b9b',
     armv7l: '6da48ac438997cc824f8f6c0be75caceebcc8bcebc7f1c54d1a62699fc388b9b',
       i686: '9ebe8ce5b7e89c1caf645327ec654dc5de6c27ecaebcc6c536e07cc6cd1052e1',
     x86_64: '1c8c176dd30f3b9ec3b418f8cb37822261ccebdaf0b01d9b8abf60213d1205cb'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
