require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.23.2'
  compatibility 'all'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.2/v2ray-linux-arm.zip'
    source_sha256 '6755c3f35e488e796ecf8d4765be0434057212aae13cd2041a1f275dffd59220'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.2/v2ray-linux-32.zip'
    source_sha256 '55ee0eeaefff9fa42703ecf62ff472610079c4e1e9f8ce1bc62da67559a99507'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.23.2/v2ray-linux-64.zip'
    source_sha256 '791b2974f2f8373844fc3f1e9d93534ebb35b7dfb2ee041de5d6ab9d33f06dd4'
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
