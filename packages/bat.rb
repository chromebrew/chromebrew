require 'package'

class Bat < Package
  description 'Clone of cat with syntax highlighting and Git integration'
  homepage 'https://github.com/sharkdp/bat'
  version '0.26.1'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '410350b51436461dbdb4b0056203dcf4d30fc303873659ad837678cdf52c42b7',
     armv7l: '410350b51436461dbdb4b0056203dcf4d30fc303873659ad837678cdf52c42b7',
       i686: '336b20f63899322fde693792e5f8c31e343777dca2b00bdcdfa197b71eb79364',
     x86_64: '726f04c8f576a7fd18b7634f1bbf2f915c43494c1c0f013baa3287edb0d5a2a3'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bat', "#{CREW_DEST_PREFIX}/bin/bat", mode: 0o755
    FileUtils.install 'bat.1', "#{CREW_DEST_MAN_PREFIX}/man1/bat.1", mode: 0o644
  end
end
