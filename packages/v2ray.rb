require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version 'v5.7.0'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: 'https://github.com/v2fly/v2ray-core/releases/download/v5.7.0/v2ray-linux-arm32-v7a.zip',
     armv7l: 'https://github.com/v2fly/v2ray-core/releases/download/v5.7.0/v2ray-linux-arm32-v7a.zip',
       i686: 'https://github.com/v2fly/v2ray-core/releases/download/v5.7.0/v2ray-linux-32.zip',
     x86_64: 'https://github.com/v2fly/v2ray-core/releases/download/v5.7.0/v2ray-linux-64.zip'
  })

  source_sha256({
    aarch64: '18fe896de67f7a351958c13f86c6b390806576e619c5e5414a6992241fedc997',
     armv7l: '18fe896de67f7a351958c13f86c6b390806576e619c5e5414a6992241fedc997',
       i686: 'd86adac01e7544489f2efc4c6c7d6f2ca2e0414be252fc00fbac408d6aba4221',
     x86_64: 'a2b689865072bff4c3d5ef6ee7970628f94a0996f86ff98c06e4ac4cc8c039f8'
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
    puts <<~EOT.lightblue
      To start using v2ray, type `v2ray`.

      For more information, see https://www.v2fly.org/en_US/guide/start.html#novice-guide?
    EOT
  end
end
