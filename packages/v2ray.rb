require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.18.0'
  source_url 'https://github.com/v2ray/v2ray-core/archive/v4.18.0.zip'
  source_sha256 '95068cbae73a3c11d332f82241d3431e203babb0e24afb9237c8e6df17f1f6dd'

  binary_url ({
    aarch64: 'https://github.com/dx0eu/v2rew/releases/download/v4.18.0/v2ray-chromeos-aarch64.tar.xz',
    armv7l: 'https://github.com/dx0eu/v2rew/releases/download/v4.18.0/v2ray-chromeos-armv7l.tar.xz',
      i686: 'https://github.com/dx0eu/v2rew/releases/download/v4.18.0/v2ray-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/dx0eu/v2rew/releases/download/v4.18.0/v2ray-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef0da5acfe0512d9b8d21d10b93ed7e5ef3d490df77f884d8f13af33f20c4879',
    armv7l: 'dcab9210822e614ee497444ca44fcadfc9c3db084ba3566e09bdd8ac13286466',
      i686: '6f1fb32a74732f2c8271897aa92f00dea941bdc1998e9a5b44d578e62c0cdc1e',
    x86_64: '7bc56c99362d2dfa846c067d9a842e67c0912eb89c5708f9929b6c9866eea91d',
  })

  def self.postinstall
    FileUtils.chmod('u=x,go=x', CREW_PREFIX + '/share/v2ray/v2ray')
    FileUtils.chmod('u=x,go=x', CREW_PREFIX + '/share/v2ray/v2ctl')

    puts
    puts 'To start using v2ray, type `v2ray`.'.lightblue
    puts
    puts 'You can use customer config. about how to use v2ray command, see https://www.v2ray.com/'.lightblue
    puts 'If you want to remove v2ray'.lightblue
    puts
    puts 'crew remove v2ray'.lightblue
    puts
  end

end
