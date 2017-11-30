require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.8.0-1'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.8.0.tar.gz'
  source_sha256 '248283ee3c24b0dbffb79ed685bdd518554073090c1c167d07ad2a729db26633'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d7f1f55c7638e2991bc634de5b8bf7af4aa47321bb304cdcebfa3fa30bcb0bf',
     armv7l: '5d7f1f55c7638e2991bc634de5b8bf7af4aa47321bb304cdcebfa3fa30bcb0bf',
       i686: '4841e28fff7332962646ab481405e3cad106224a673398e6292703533c85f63e',
     x86_64: '0263d3a55d4d86358aac7a8f828b7747a57c13b78daee3a355b729ea8c8e7f54',
  })

  depends_on 'bc'

  def self.build
  end

  def self.install
    system "install -D screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
