require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7-unknown-linux-musleabi.tar.gz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7-unknown-linux-musleabi.tar.gz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'd810555a1590483ce931df038f60ff7bce31fd61404c7f6b6278441164f22f4a',
     armv7l: 'd810555a1590483ce931df038f60ff7bce31fd61404c7f6b6278441164f22f4a',
       i686: '051885e16f6a5bac29ba91384cfedc189b4b6792f490e192e8ece07d46d04955',
     x86_64: 'af589cf82cc9ea9c29ce050b9239a13bef2d1492256d476156e1054a42ce89ad'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
