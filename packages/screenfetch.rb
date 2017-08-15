require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.7.0'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.7.0.tar.gz'
  source_sha256 '6711fe924833919d53c1dfbbb43f3777d33e20357a1b1536c4472f6a1b3c6be0'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/screenfetch-3.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/screenfetch-3.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/screenfetch-3.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/screenfetch-3.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ae230a5057261354e7ff68120509b9fa4792b5af22b5652d313b00e54b9cdbca',
     armv7l: 'ae230a5057261354e7ff68120509b9fa4792b5af22b5652d313b00e54b9cdbca',
       i686: '07ed19dfd9ca9cd1aa10f8344c35bd898dda10c830c03b41aaa9a900a6765e72',
     x86_64: 'b362fecc330686e6cf334a1ecc2a33f79b19add1d266200ad1d0ff78c4243693',
  })

  def self.build
  end

  def self.install
    system "install -D screenfetch-dev #{CREW_DEST_DIR}/usr/local/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_DIR}/usr/local/man/man1/screenfetch.1"
  end
end
