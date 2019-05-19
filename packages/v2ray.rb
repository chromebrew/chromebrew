require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.18.2'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.18.2/v2ray-linux-arm.zip'
    source_sha256 '95d448bd91653ed5203799a93847d496a04791ebb89627bcd6dc421910ae6c04'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.18.2/v2ray-linux-32.zip'
    source_sha256 '5dda9cfd98a4d516affbe236173c8890e93ea21e0348c22776e97f2fc4bf4965'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.18.2/v2ray-linux-64.zip'
    source_sha256 '48402ad3143cbf109e80c4f26d958620b85d7e08d00c37c136beb1e5b83b9903'
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
