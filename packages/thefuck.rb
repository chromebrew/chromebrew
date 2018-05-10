require 'package'

class Thefuck < Package
  description 'Magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck'
  version '3.26'
  source_url 'https://raw.githubusercontent.com/nvbn/thefuck/3.26/README.md'
  source_sha256 '105e10e37c4c1430fe6bc3a48c9508254048721825ae14856d713de61c95bc66'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/thefuck-3.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/thefuck-3.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/thefuck-3.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/thefuck-3.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ed01911cf4191dcc4b4772d2c37c27e1d852e4ae05936a542c78ea893e6b243',
     armv7l: '3ed01911cf4191dcc4b4772d2c37c27e1d852e4ae05936a542c78ea893e6b243',
       i686: '00d031f9cd4cf33b52b7906e9cfddc1c57b21bb4aba201e1e326fd5be4e85687',
     x86_64: 'abef43017782a8a921cb73b2c32c4b5eaab6ec5412b136aeea2a2ad9ea960de0',
  })

  depends_on 'python3'

  def self.install
    system "pip3 install thefuck --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.postinstall
    system 'fuck && fuck'
  end
end
