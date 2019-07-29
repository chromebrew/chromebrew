require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.20.0'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.20.0/v2ray-linux-arm.zip'
    source_sha256 '30192aa5efd630b94c9151c59f131437ba8248789a5662e80bab803d5155f0b9'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.20.0/v2ray-linux-32.zip'
    source_sha256 '1478c916f491d1262f80aa4fd84894c61a165a80a0a6ba6f08973843b450a166'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.20.0/v2ray-linux-64.zip'
    source_sha256 'ef2a6748dad7aaa8dba68589f3860f336b7ac63deac73214970855657c8d9e86'
  end

  def self.install
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/v2ray')
    FileUtils.cp_r('.', CREW_DEST_PREFIX + '/share/v2ray')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.cd(CREW_DEST_PREFIX + '/bin') do
      FileUtils.ln_s(CREW_PREFIX + '/share/v2ray/v2ray', 'v2ray')
      FileUtils.ln_s(CREW_PREFIX + '/share/v2ray/v2ctl', 'v2ctl')
    end
  end

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
