require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.21.0'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.0/v2ray-linux-arm.zip'
    source_sha256 'e5c6307cee284c7dd7a5c6ed934de4649f9389881c6deb98a608757aef356982'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.0/v2ray-linux-32.zip'
    source_sha256 '7955ec47d512001474e8cd768f56bff26bc10a69fbd1a4d32d0f5e64d9dbdf11'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.0/v2ray-linux-64.zip'
    source_sha256 '8ff8faf11a3d631a20863ac7c827da86f0fab3abe935cd936f42170cd029c42d'
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
