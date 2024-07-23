require 'package'

class Gifgen < Package
  description 'Simple high quality GIF encoding'
  homepage 'https://github.com/lukechilds/gifgen'
  version '1.1.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/lukechilds/gifgen/archive/1.1.2.tar.gz'
  source_sha256 '95f69c63158315ad869ff36611026cce1a7d03f8c84716b1c21a44e71e8d6aee'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e1eadb94916b24ff42c9ea9dbeb3c16e2683f9dc392d39872cb355b5f54addc0',
     armv7l: 'e1eadb94916b24ff42c9ea9dbeb3c16e2683f9dc392d39872cb355b5f54addc0',
     x86_64: '665fff725b0e73e5f5ac373b9418f7398eb9291d0e9eda72852c58ed1b543021'
  })

  depends_on 'ffmpeg'
  depends_on 'help2man'

  def self.install
    system 'help2man -N ./gifgen > gifgen.1'
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp gifgen #{CREW_DEST_PREFIX}/bin"
    system "cp gifgen.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end
