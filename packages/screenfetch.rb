require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.9.1'
  compatibility 'all'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.9.1.tar.gz'
  source_sha256 'aa97dcd2a8576ae18de6c16c19744aae1573a3da7541af4b98a91930a30a3178'

  depends_on 'bc'

  def self.build
  end

  def self.install
    system "install -Dm755 screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
