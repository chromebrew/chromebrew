require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.7.8'
  license 'Apache-2.0, BSD-2, BSD-4, MIT, MPL-2.0 and unicode'
  compatibility 'all'
  source_url ({
    aarch64: 'https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_arm.zip',
     armv7l: 'https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_arm.zip',
       i686: 'https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_386.zip',
     x86_64: 'https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_amd64.zip',
  })
  source_sha256 ({
    aarch64: 'e9fce8a6ccaae3d7aecad55d06366730f215285bb4572acd308a09837ee4517f',
     armv7l: 'e9fce8a6ccaae3d7aecad55d06366730f215285bb4572acd308a09837ee4517f',
       i686: '46e49526e3900ee56c738c7a3415112a82af67f3627cc46cd85ee1b2316e4ffe',
     x86_64: '8a94b84542d21b8785847f4cccc8a6da4c7be5e16d4b1a2d0a5f7ec5532faec0',
  })

  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'packer', "#{CREW_DEST_PREFIX}/bin/packer", mode: 0o755
  end
end
