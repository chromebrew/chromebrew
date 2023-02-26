require 'package'

class V2ray < Package
  description 'A platform for building proxies to bypass network restrictions.'
  homepage 'www.v2fly.org'
  version 'v5.3.0'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: 'https://github.com/v2fly/v2ray-core/releases/download/v5.3.0/v2ray-linux-arm32-v7a.zip',
     armv7l: 'https://github.com/v2fly/v2ray-core/releases/download/v5.3.0/v2ray-linux-arm32-v7a.zip',
       i686: 'https://github.com/v2fly/v2ray-core/releases/download/v5.3.0/v2ray-linux-32.zip',
     x86_64: 'https://github.com/v2fly/v2ray-core/releases/download/v5.3.0/v2ray-linux-64.zip'
  })

  source_sha256({
    aarch64: 'd782a7efa04dda771751c43bb7096c1fde0879bbd1df65e796895fa9baba5c74',
     armv7l: 'd782a7efa04dda771751c43bb7096c1fde0879bbd1df65e796895fa9baba5c74',
       i686: 'c3bc3da7e1a5288299230856bf3b3f63762794d47997dba50c23760c6e517712',
     x86_64: '6cf089757128eac6d823e50e91e4dbe4f2492170d24b8721ee5dc6ec3f7d3c9c'
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
