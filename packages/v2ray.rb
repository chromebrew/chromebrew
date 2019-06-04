require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.19.1'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.19.1/v2ray-linux-arm.zip'
    source_sha256 '229573bb79ef8699d5930ef1934b8ef4a7dc3eec02fed74c48bfbbedbe843c20'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.19.1/v2ray-linux-32.zip'
    source_sha256 '3554f4ab470a5e7dad5bdb90d3d3fc95ba5fb8ac6859da81b16a1428b5fc0129'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.19.1/v2ray-linux-64.zip'
    source_sha256 'e8c077e9fd3d827d161b7b021a7aeb49f2b35e0152f75ee658d36938a6478025'
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
