require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7-unknown-linux-musleabi.tar.gz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7-unknown-linux-musleabi.tar.gz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '8d06453d1a71621731429026b6c131d3a73e4309135a2272eeef56e86b12305a',
     armv7l: '8d06453d1a71621731429026b6c131d3a73e4309135a2272eeef56e86b12305a',
       i686: 'ca9d80d71cd86e9f77515fcd20ca3f4d2e4f84abfb1d2ea3768265fd50a15f1e',
     x86_64: '5099054dd6a101bd12eb6ff3702a9a6a3f57aaa27923a0da478ae5b517faf335'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
