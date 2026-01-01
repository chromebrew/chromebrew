require 'package'

class Enet < Package
  description 'ENet reliable UDP networking library'
  homepage 'https://github.com/lsalzman/enet'
  version '1.3.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lsalzman/enet.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6eb360adef080a2b6ac1954086cce85537f9899bbf4d2f8b49e6dacd9ade1a7',
     armv7l: 'f6eb360adef080a2b6ac1954086cce85537f9899bbf4d2f8b49e6dacd9ade1a7',
       i686: 'd666bba3ba04f0895215641257190582fcfbcd1f898c111156fcd6ab158e930a',
     x86_64: '3f8e7519ccfd3d65c4834bf66157e5df9e84a6451a4d73c520a08ce5fd738039'
  })

  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -vfi'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
