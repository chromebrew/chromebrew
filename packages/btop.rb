require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-linux-musl.tbz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-linux-musl.tbz"
  })
  source_sha256({
    aarch64: '3ec9228ee74334eaea1601e5813afbca936323665b323fefba1393022518e3d6',
     armv7l: '3ec9228ee74334eaea1601e5813afbca936323665b323fefba1393022518e3d6',
       i686: '9c73269c11b04692c724d3364c1dd9c6a41a4f678165a433de23a4cd8d04ea72',
     x86_64: 'fec7d1b59c671290a0f80d5a32617ea6d60412485fc04318fd194b9550ff6b49'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
