require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.22.1'
  compatibility 'all'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.22.1/v2ray-linux-arm.zip'
    source_sha256 '8fa800ee4a8d62d3d9970cfe6883c39b22637ac902d73391973cb2c9c08fed07'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.22.1/v2ray-linux-32.zip'
    source_sha256 '27194ae58ab74096c77c99a7ed40c727eced7fd17b523cfc8295985134605691'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.22.1/v2ray-linux-64.zip'
    source_sha256 '4a93d05127deb1f921ad88dca0c5cde5d7e664531a1b6bfdebfa4d4bac1c6348'
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
