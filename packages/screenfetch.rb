require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.9.0'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.9.0.tar.gz'
  source_sha256 'd6df4ef7763f9761d818c878465d78ef701b71002a50d4f150f65a31cc1bea37'

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
