require 'package'

class Gifgen < Package
  description 'Simple high quality GIF encoding'
  homepage 'https://github.com/lukechilds/gifgen'
  version '1.1.2'
  compatibility 'all'
  source_url 'https://github.com/lukechilds/gifgen/archive/1.1.2.tar.gz'
  source_sha256 '95f69c63158315ad869ff36611026cce1a7d03f8c84716b1c21a44e71e8d6aee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gifgen-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gifgen-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gifgen-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gifgen-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1eadb94916b24ff42c9ea9dbeb3c16e2683f9dc392d39872cb355b5f54addc0',
     armv7l: 'e1eadb94916b24ff42c9ea9dbeb3c16e2683f9dc392d39872cb355b5f54addc0',
       i686: 'b5488a7cdf68252ceed0a1cf344bbba166fb98e388bc345436e4bc32da4664a9',
     x86_64: '665fff725b0e73e5f5ac373b9418f7398eb9291d0e9eda72852c58ed1b543021',
  })

  depends_on 'ffmpeg'
  depends_on 'help2man'

  def self.install
    system "help2man -N ./gifgen > gifgen.1"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp gifgen #{CREW_DEST_PREFIX}/bin"
    system "cp gifgen.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end
