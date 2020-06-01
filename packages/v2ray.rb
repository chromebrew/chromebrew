require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.23.3'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.3/v2ray-linux-arm.zip'
    source_sha256 '0b5f2dc349739d1e712798c04ef5cf94156729329dd66ff2c4c3e9927dd3f255'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.3/v2ray-linux-32.zip'
    source_sha256 '0657b335261edd6ffb24a29f1f594e92414901cc56e09711d9532e94a03f395b'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.3/v2ray-linux-64.zip'
    source_sha256 'ad3c272b03cd682a427c70c4ea6079bfbf614bf5978f69a0d1b77d673aa913ae'
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
