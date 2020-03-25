require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'V4.23.1'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/V4.23.1/v2ray-linux-arm.zip'
    source_sha256 '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/V4.23.1/v2ray-linux-32.zip'
    source_sha256 '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/V4.23.1/v2ray-linux-64.zip'
    source_sha256 '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5'
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
