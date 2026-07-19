require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version '5.51.2'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
     armv7l: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
       i686: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-32.zip",
     x86_64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-64.zip"
  })
  source_sha256({
    aarch64: '2230e2297461993fb41cde9e28c5a4ef1a7a4aeeadc6d29fe61c1b7cfb6653e4',
     armv7l: '2230e2297461993fb41cde9e28c5a4ef1a7a4aeeadc6d29fe61c1b7cfb6653e4',
       i686: 'fe03e96473314ed4730c3d9746fc99b4d127f8b2877ef7ce99bc1e59bf9c7c8c',
     x86_64: '7d034da48fb445fe0acd477ffc8fa9712c68cdf02f1431e3ed9c54c10bf81db3'
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
    ExitMessage.add <<~EOT

      To start using v2ray, type `v2ray`.

      For more information, see https://www.v2fly.org/en_US/guide/start.html#novice-guide?
    EOT
  end
end
