require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.21.1'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.1/v2ray-linux-arm.zip'
    source_sha256 '807d7773c329b4bbb5fe0dcf7674c30c4e3dbc898d88c867b24d9b9210ff3d78'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.1/v2ray-linux-32.zip'
    source_sha256 'd34b7cbdb5c307024197dd219c4a5dbf0ae6cc39f01bdf358648ea0b85b163e7'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.21.1/v2ray-linux-64.zip'
    source_sha256 '9f983747b6a3c35046486f35ffeb66eedf1fa347c09e282843ab2e26faa14191'
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
