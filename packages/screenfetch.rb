require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.8.0'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.8.0.tar.gz'
  source_sha256 '248283ee3c24b0dbffb79ed685bdd518554073090c1c167d07ad2a729db26633'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd728b9a8b6b3ef433587826f243c372a7589b84df0adcb4280199d7f771ee6ab',
     armv7l: 'd728b9a8b6b3ef433587826f243c372a7589b84df0adcb4280199d7f771ee6ab',
       i686: 'c8e6b6aadbe2d56b87c9866b437d8e794815c7331cd8d692573712d07d41d95d',
     x86_64: '0c90ff765e88b492e37bb101d5ee95443586c3a2555ccccb5bf5bd0f8da892d2',
  })

  def self.build
  end

  def self.install
    system "install -D screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
