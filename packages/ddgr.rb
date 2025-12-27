require 'package'

class Ddgr < Package
  description 'DuckDuckGo from the terminal'
  homepage 'https://github.com/jarun/ddgr'
  version '2.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/jarun/ddgr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9de1131fa33e0e6342539141ffb7d9ec85d4a07c69e636623c570b0f691fbfde',
     armv7l: '9de1131fa33e0e6342539141ffb7d9ec85d4a07c69e636623c570b0f691fbfde',
       i686: '67b5c30402d7a408c4b5e3fafc4ad3a671fb217ec01656c74dee500fd5c0c61c',
     x86_64: '6896cfe7b07f2a49846d5a75510ab737dfab3f4aa678c598e5ff34e61a037366'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
