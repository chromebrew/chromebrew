require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.8.0-1'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.8.0.tar.gz'
  source_sha256 '248283ee3c24b0dbffb79ed685bdd518554073090c1c167d07ad2a729db26633'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'bc'

  def self.build
  end

  def self.install
    system "install -D screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
