require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.12.0'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '29c8cb058b6d0d68c84e4a322c4abb1b11bdfe926d9a16ccbf4e026b8df75e49',
     armv7l: '29c8cb058b6d0d68c84e4a322c4abb1b11bdfe926d9a16ccbf4e026b8df75e49',
       i686: '2fba1a4d61386805069416764da34bb7af1d48747530be570a9452b28f6d99fa',
     x86_64: 'e859a76659570d1e29fa55396d5d908091bacacd4567c17770e616c4b58c9ace'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
