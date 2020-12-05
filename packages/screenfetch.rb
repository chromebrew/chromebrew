require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.9.1'
  compatibility 'all'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.9.1.tar.gz'
  source_sha256 'aa97dcd2a8576ae18de6c16c19744aae1573a3da7541af4b98a91930a30a3178'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3cd66c744cc13b3527d1b0840a7a2093ac45c1bf2fb10871ccc8a63a3e98c948',
     armv7l: '3cd66c744cc13b3527d1b0840a7a2093ac45c1bf2fb10871ccc8a63a3e98c948',
       i686: '8c601b89335b94383480a9fd0e0fe6ac5fe364d27e4a5a8df19319df9b22aacd',
     x86_64: 'dcadb8b83bf61c17e40f0505dca47f50e7b177a55e79614fdf64a3b78410b404',
  })

  depends_on 'bc'

  def self.install
    system "install -Dm755 screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
