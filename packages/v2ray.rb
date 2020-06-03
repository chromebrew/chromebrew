require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.23.4'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.4/v2ray-linux-arm.zip'
    source_sha256 '96ea08331b4f61208810c26263fc828c115d7eee863f9cd6f35e89890d10535f'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.4/v2ray-linux-32.zip'
    source_sha256 '78f98992e4bff6f44d1c7bc493c5e82d183a8510f555f65fa359995282c99249'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.4/v2ray-linux-64.zip'
    source_sha256 '38f02c2d3f054ec228f0f29a4185431b89f06f7b6a7a8f795e12ae48eaa591ba'
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
