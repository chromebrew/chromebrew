require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.22.0'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.22.0/v2ray-linux-arm.zip'
    source_sha256 '94b472d7afb24401a46f01b5b7fcaae925cec929b186ccdeec6967e3ceec2ed4'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.22.0/v2ray-linux-32.zip'
    source_sha256 'ed6f0327e6da79486f143cc3de74cd45ca08125574934243d2a85ed1db7a95a8'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.22.0/v2ray-linux-64.zip'
    source_sha256 '23be032742a212937549904ed7713217e8978e0e10854fe3790a0718ff1d9440'
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
