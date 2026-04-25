require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.15.2'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '6624ff7bf81e1eeb18367704849c7b78b9c14625581da9a83c534c2a961b7e16',
     armv7l: '6624ff7bf81e1eeb18367704849c7b78b9c14625581da9a83c534c2a961b7e16',
       i686: '5dc76e9eaf8fa7fd7453f35bf6cee20bcd907f5c02b891d7c1c4a0e9f5a193e8',
     x86_64: '8cc4bc94a7e6d8806dd754869945287918aaa3c55bebdfa5169e33cd1dcf35c6'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
