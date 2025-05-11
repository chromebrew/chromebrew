require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-linux-musl.tbz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-linux-musl.tbz"
  })
  source_sha256({
    aarch64: '25df48ee78f1c70d47dc30df7dd92fc431770a3fc60864d003553bc9e7cc1f6b',
     armv7l: '25df48ee78f1c70d47dc30df7dd92fc431770a3fc60864d003553bc9e7cc1f6b',
       i686: '366b1c7300b4ff37fe632566523e2331f54b52beedb2e5152a0f9bf65598d7bb',
     x86_64: '03869e0007874bfca7d995501568b68c0d2e2be770f2268859f876dc3edff657'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
