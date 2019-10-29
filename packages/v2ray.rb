require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.21.3'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.3/v2ray-linux-arm.zip'
    source_sha256 '847546a057f2a2ae477092b997192972b66e19f5f9bae53f23849459ff0d68a8'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.3/v2ray-linux-32.zip'
    source_sha256 '3d9adcc02c48666ea668ac0891a2c584b19afcdba5e8a36953320063050243c7'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.3/v2ray-linux-64.zip'
    source_sha256 '7db90a290cd945a2c802fd07907dd9b008b9b26b5d057730e4f1d438965b219a'
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
