require 'package'

class Wbox < Package
  description 'Wbox aims to help you having fun while testing HTTP related stuff.'
  homepage 'http://www.hping.org/wbox/'
  version '5'
  license 'BSD'
  compatibility 'all'
  source_url 'http://www.hping.org/wbox/wbox-5.tar.gz'
  source_sha256 '1589d85e83c8ee78383a491d89e768ab9aab9f433c5f5e035cfb5eed17efaa19'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '3494092bd7e35a74a42844ea5be0a91832e3368c8ecb23088fda343acf811efc',
     armv7l: '3494092bd7e35a74a42844ea5be0a91832e3368c8ecb23088fda343acf811efc',
       i686: 'b131b6a44ac7c1884f5a337d5f40615b6e0b23ca1f23f552d132bf091eb86878',
     x86_64: 'f976840c5973ad940ef5451847395f85ae5927ab14893b15fda9e8f8c4345282'
  })

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp 'wbox', "#{CREW_DEST_PREFIX}/bin/"
  end
end
