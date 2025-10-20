require 'package'

class Bat < Package
  description 'Clone of cat with syntax highlighting and Git integration'
  homepage 'https://github.com/sharkdp/bat'
  version '0.26.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'a89852665ae4b91d2d3571a3d0920cfad0878bcc1370caba1ebc592a6ffad678',
     armv7l: 'a89852665ae4b91d2d3571a3d0920cfad0878bcc1370caba1ebc592a6ffad678',
       i686: '349bb5c11288bebbb28474663ed75f2a0a7d2c4596a08e46d11fd43ea82d2b60',
     x86_64: '7efed0c768fae36f18ddbbb4a38f5c4b64db7c55a170dfc89fd380805809a44b'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bat', "#{CREW_DEST_PREFIX}/bin/bat", mode: 0o755
    FileUtils.install 'bat.1', "#{CREW_DEST_MAN_PREFIX}/man1/bat.1", mode: 0o644
  end
end
