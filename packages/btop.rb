require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7l-linux-musleabihf.tbz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-linux-musl.tbz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-linux-musl.tbz"
  })
  source_sha256({
    aarch64: '2e34a699a940cd1da70e1ee50f387e4ba899483c021571cbbf54d1a52dbcfe18',
     armv7l: '2e34a699a940cd1da70e1ee50f387e4ba899483c021571cbbf54d1a52dbcfe18',
       i686: '0ea7f6e0f1d6fcbf9981455e2744fb0365f4b0872bbc4cf3e3596e5f32ee9ff4',
     x86_64: '206b0f9334e93c06de9025eaf90676c374ca79815b41dadff1b36ef4e4e6d1d4'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
