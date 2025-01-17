require 'package'

class Bat < Package
  description 'Clone of cat with syntax highlighting and Git integration'
  homepage 'https://github.com/sharkdp/bat'
  version '0.25.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '8248de4331da04d71fab8894af80077227e7e3f7429b9179bc5d28aaec51d4b4',
     armv7l: '8248de4331da04d71fab8894af80077227e7e3f7429b9179bc5d28aaec51d4b4',
       i686: '9379470b5f674b82eaa1821dbda664ebe40f1953cca16786f3e403e8e3c85627',
     x86_64: '31bbbcc0d9f5abe16399425c98ffbf21aaa0ce190c7b75d4f32297696ff32b81'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bat', "#{CREW_DEST_PREFIX}/bin/bat", mode: 0o755
    FileUtils.install 'bat.1', "#{CREW_DEST_MAN_PREFIX}/man1/bat.1", mode: 0o644
  end
end
