require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.15.0'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/packer/#{version}/packer_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '7d5ee19adc7659720f03363c27e914945204eadb633ad5a3c37a3719f20e6eee',
     armv7l: '7d5ee19adc7659720f03363c27e914945204eadb633ad5a3c37a3719f20e6eee',
       i686: '13c1a0cc1112807a6900d14c83f6d3ce79f9474eeab7a09031aba01cb68665f5',
     x86_64: '2fd1149c5c6c7604ced64d7b56638af05f6b7ed3f6835182bc913ddaba1f16b8'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
