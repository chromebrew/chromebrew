require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.24.2'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.24.2/v2ray-linux-arm.zip'
    source_sha256 'd6c93961c0c192097cadadc73e3a4b2cc6fff722851af9c073ea2612f996a3b7'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.24.2/v2ray-linux-32.zip'
    source_sha256 '7a72f5dc9ee9b38fc9a827b555150714da19905d27d88f23b1ae3adb411a0ece'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.24.2/v2ray-linux-64.zip'
    source_sha256 '2d763daae301869bdb1e8cc5ef851bd5f8a3eefd2cd31c400b7830c36398d903'
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
