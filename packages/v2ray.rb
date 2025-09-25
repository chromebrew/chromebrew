require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version 'v5.39.0'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/v2fly/v2ray-core/releases/download/#{version}/v2ray-linux-arm32-v7a.zip",
     armv7l: "https://github.com/v2fly/v2ray-core/releases/download/#{version}/v2ray-linux-arm32-v7a.zip",
       i686: "https://github.com/v2fly/v2ray-core/releases/download/#{version}/v2ray-linux-32.zip",
     x86_64: "https://github.com/v2fly/v2ray-core/releases/download/#{version}/v2ray-linux-64.zip"
  })
  source_sha256({
    aarch64: 'dcf53be54ba0f3f481e7e13eb6f9d51bd2bbbff6b76daf29f73f22d79d21ff04',
     armv7l: 'dcf53be54ba0f3f481e7e13eb6f9d51bd2bbbff6b76daf29f73f22d79d21ff04',
       i686: '9fb36d15e8cb9c02217909f39d21e4626baeae8c08609e81ffd50f07049c4b2f',
     x86_64: '793f7e75a6fd2bfd03076253a7a4d58f05beb059e6fc0519ec5c0c2677fabe20'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/etc/v2ray #{CREW_DEST_PREFIX}/share/v2ray]
    FileUtils.chmod 0o755, 'v2ray'
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/v2ray"
    FileUtils.ln_s "#{CREW_PREFIX}/share/v2ray/v2ray", "#{CREW_DEST_PREFIX}/bin/v2ray"
    FileUtils.ln_s "#{CREW_PREFIX}/share/v2ray/config.json", "#{CREW_DEST_PREFIX}/etc/v2ray/config.json"
  end

  def self.postinstall
    ExitMessage.add <<~EOT.lightblue
      To start using v2ray, type `v2ray`.

      For more information, see https://www.v2fly.org/en_US/guide/start.html#novice-guide?
    EOT
  end
end
