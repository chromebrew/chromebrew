require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.25.0'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.25.0/v2ray-linux-arm.zip'
    source_sha256 '38aedb5e3c30ca19bcfa58db1765ab26ff8c8ecc86919b0a9c14d6d058c0e695'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.25.0/v2ray-linux-32.zip'
    source_sha256 '8c72140752543ad8025b4e2605b43b399cd84b45828a0d26d9103fd33de3cc1c'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.25.0/v2ray-linux-64.zip'
    source_sha256 '99e2bc04c6ac1a6d27dd60b0f461689a3207f9fa927d31efcedfd3c2239a31aa'
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
