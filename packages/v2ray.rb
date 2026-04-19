require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version '5.48.0'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
     armv7l: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-arm32-v7a.zip",
       i686: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-32.zip",
     x86_64: "https://github.com/v2fly/v2ray-core/releases/download/v#{version}/v2ray-linux-64.zip"
  })
  source_sha256({
    aarch64: '4b1512ef735a7e4f78d0f0195987fc8ad7f8a1fa0b68c4953952a2280699f5c5',
     armv7l: '4b1512ef735a7e4f78d0f0195987fc8ad7f8a1fa0b68c4953952a2280699f5c5',
       i686: '2fc95a4777f0edf0d19cce7d2b8f6139de1244c1725bdd02e6015da396720c8e',
     x86_64: '7399f48845e87864280a4e34084ac796cd22fa008fb0f34460526f659dbdfe52'
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
