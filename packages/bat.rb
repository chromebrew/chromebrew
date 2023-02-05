require 'package'

class Bat < Package
  description 'Clone of cat with syntax highlighting and Git integration'
  homepage 'https://github.com/sharkdp/bat'
  version '0.22.1'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-arm-unknown-linux-gnueabihf.tar.gz',
     armv7l: 'https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-arm-unknown-linux-gnueabihf.tar.gz',
       i686: 'https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-i686-unknown-linux-gnu.tar.gz',
     x86_64: 'https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-x86_64-unknown-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: '1e390f9af728142afb1e454965b4722ce35165dcc7f8d9ca1e902deb9b3f8ff2',
     armv7l: '1e390f9af728142afb1e454965b4722ce35165dcc7f8d9ca1e902deb9b3f8ff2',
       i686: 'dc57b012470cfa9e7f4f0aa1c491c779f23a10bb504f59b798234aab5d33e790',
     x86_64: 'eb81510a3d14d3a15353cb9c5edb2e037fbce07ee8e986c8c63c94ad55368acf'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'bat', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'bat.1', "#{CREW_DEST_MAN_PREFIX}/man1", mode: 0o755
  end
end
