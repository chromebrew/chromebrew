require 'package'

class Bat < Package
  description 'Clone of cat with syntax highlighting and Git integration'
  homepage 'https://github.com/sharkdp/bat'
  version '0.23.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-arm-unknown-linux-gnueabihf.tar.gz',
     armv7l: 'https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-arm-unknown-linux-gnueabihf.tar.gz',
       i686: 'https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-i686-unknown-linux-gnu.tar.gz',
     x86_64: 'https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: 'badbcf12c9aa4b03cc9c0df8a9c21141172981f55bfff28a0cb8ea58bea1eb41',
     armv7l: 'badbcf12c9aa4b03cc9c0df8a9c21141172981f55bfff28a0cb8ea58bea1eb41',
       i686: 'e2391d17fafb94a61fb04c85c9b00ef77d2282bdc4c45dc15ed1c8bd52643133',
     x86_64: '901c7a0f2e54ea6ecd33f56a13b14ded265a24393421b0c99ad9f4563a8be4a1'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'bat', "#{CREW_DEST_PREFIX}/bin/bat", mode: 0o755
    FileUtils.install 'bat.1', "#{CREW_DEST_MAN_PREFIX}/man1/bat.1", mode: 0o644
  end
end
