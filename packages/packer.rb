require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.11.2'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '2f6e1928204b61f171b9d79cbc697a5b35c65cd435e1a38bb648bb7e96dba284',
     armv7l: '2f6e1928204b61f171b9d79cbc697a5b35c65cd435e1a38bb648bb7e96dba284',
       i686: 'fe5781307673843309be41ceac6541d4322640653f6b6e6eabd85375f9d70726',
     x86_64: 'ced13efc257d0255932d14b8ae8f38863265133739a007c430cae106afcfc45a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
