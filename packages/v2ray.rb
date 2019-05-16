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
    aarch64: '7a9c6f6d97e164e155f517b506b441881a5d56bac4b757231141119abcc848f7',
    armv7l: '4a607a00c51f38716f2fa15e2f7c811bfa1719ff8360d29b71b02abfbba91dc7',
      i686: 'be1446d0c0070cab519a8a19f92b06e3837c8b054be043497422cbf8d80df36d',
    x86_64: '13a145949ac1d29bcce45b5ec1dccf0ecbcbb254c14d208b3d845616188e9e4e',
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
