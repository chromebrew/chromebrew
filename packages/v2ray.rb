require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'https://www.v2ray.com/'
  version 'v4.28.2'
  license 'MIT'
  compatibility 'all'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.28.2/v2ray-linux-arm32-v7a.zip'
    source_sha256 '9090cfc97418719e66467f296bfc2297776da14d3af127d23aa3bb196d7707e8'
  when 'i686'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.28.2/v2ray-linux-32.zip'
    source_sha256 '8b31f08f6e25609792f1d1ad6a4d9e35e4089a19ac85b30bd70b95bd48b8e9e3'
  when 'x86_64'
    source_url 'https://github.com/v2ray/v2ray-core/releases/download/v4.28.2/v2ray-linux-64.zip'
    source_sha256 'e50e6818a743f842e1bd464f81ed3e42896f68f461718d9ba0f8d75107355c11'
  end

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/v2ray")
    FileUtils.cp_r('.', "#{CREW_DEST_PREFIX}/share/v2ray")
    FileUtils.chmod('u=x', "#{CREW_DEST_PREFIX}/share/v2ray/v2ray")
    FileUtils.chmod('u=x', "#{CREW_DEST_PREFIX}/share/v2ray/v2ctl")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/bin")
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      FileUtils.ln_s("#{CREW_PREFIX}/share/v2ray/v2ray", 'v2ray')
      FileUtils.ln_s("#{CREW_PREFIX}/share/v2ray/v2ctl", 'v2ctl')
    end
  end

  def self.postinstall
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
