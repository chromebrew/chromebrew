require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version '5.53.0'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
     armv7l: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
       i686: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-32.zip",
     x86_64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-64.zip"
  })
  source_sha256({
    aarch64: 'bb90345678ea44de72599314a5aa619686b0a5f9f4a0a481de902cd45f072d72',
     armv7l: 'bb90345678ea44de72599314a5aa619686b0a5f9f4a0a481de902cd45f072d72',
       i686: 'b8dd6a677668989bffa989bd0471ced9c8669b18ed0f176f6cddfeac60fd9cf9',
     x86_64: '6bbb8aee65a57d0b12599b4b7c842b3ad0daca4436e661d94015c447cb31b4fa'
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
