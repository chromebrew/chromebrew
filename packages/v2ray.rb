require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.18.0'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.18.0/v2ray-linux-arm.zip'
    source_sha256 '9bb0b299c071cf3131dfa6eef822841d6b3fad4f9877a040f70e44e9f7f7d848'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.18.0/v2ray-linux-32.zip'
    source_sha256 'dc9876be5c9631fc23c95d934abb049639e67aa6731fa2b7ba7f160441c44a7d'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.18.0/v2ray-linux-64.zip'
    source_sha256 'e3b518795c76b26b6efdc837ebdf01a401b0a153c9758e928bd1cd4df35631ed'
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
