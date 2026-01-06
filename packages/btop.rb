require 'package'

class Btop < Package
  description 'Resource monitor that shows usage and stats for processor, memory, disks, network and processes.'
  homepage 'https://github.com/aristocratos/btop'
  version '1.4.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7-unknown-linux-musleabi.tbz",
     armv7l: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-armv7-unknown-linux-musleabi.tbz",
       i686: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-i686-unknown-linux-musl.tbz",
     x86_64: "https://github.com/aristocratos/btop/releases/download/v#{version}/btop-x86_64-unknown-linux-musl.tbz"
  })
  source_sha256({
    aarch64: 'f37622a833ab5c51881e17cefe4f27c035ec59faa55fde468f50ad0eca367e02',
     armv7l: 'f37622a833ab5c51881e17cefe4f27c035ec59faa55fde468f50ad0eca367e02',
       i686: '33499176966c0c955f3452d6d316196dc5b2568b881d94592cc082a88937274b',
     x86_64: '9bf7ed170423bb3709a8020767bd2ca529c5632af478f229dce7cdfd32b25691'
  })

  no_compile_needed

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
