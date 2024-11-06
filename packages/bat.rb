require 'package'

class Bat < Package
  description 'Clone of cat with syntax highlighting and Git integration'
  homepage 'https://github.com/sharkdp/bat'
  version '0.24.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/sharkdp/bat/releases/download/v#{version}/bat-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'f7eda9431a64ec3cedc4b576134ed3f8eac7b7fb04e076a7b186b6b65e4370e8',
     armv7l: 'f7eda9431a64ec3cedc4b576134ed3f8eac7b7fb04e076a7b186b6b65e4370e8',
       i686: '25c597011975653d9344061a126a296cf6d7f3f360a0f6d23511dc6b41e324a0',
     x86_64: '0faf5d51b85bf81b92495dc93bf687d5c904adc9818b16f61ec2e7a4f925c77a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bat', "#{CREW_DEST_PREFIX}/bin/bat", mode: 0o755
    FileUtils.install 'bat.1', "#{CREW_DEST_MAN_PREFIX}/man1/bat.1", mode: 0o644
  end
end
