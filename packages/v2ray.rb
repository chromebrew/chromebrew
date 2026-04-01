require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version '5.47.0'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
     armv7l: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
       i686: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-32.zip",
     x86_64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-64.zip"
  })
  source_sha256({
    aarch64: 'e594c1f699ab0977a815cea8621e63e5519f3d0877c668400228b4f57eff2dd8',
     armv7l: 'e594c1f699ab0977a815cea8621e63e5519f3d0877c668400228b4f57eff2dd8',
       i686: 'fb36944a90799b210b51c28fb69b4cf4464869cc9d59989663be045488a6d43d',
     x86_64: '56215328ad7a65e387e772af22232ac6531c34a1bb2252a64599a3a41aa7de5c'
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
