require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-linux-musl.tbz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-linux-musl.tbz"
  })
  source_sha256({
    aarch64: '7f793a78c875829b14ded0c9dd3e851a284a50b9eaefdf9407e93d8f767993f5',
     armv7l: '7f793a78c875829b14ded0c9dd3e851a284a50b9eaefdf9407e93d8f767993f5',
       i686: '987ab934b52f6e4cfddd3d4706142963f45e4b8a4d4fdeed3b45e27331892954',
     x86_64: '2e49cde9c0f273e5b1699d2c4f1ce5d1c08cca5fd90e5e0226dbac9fd00c82f3'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
