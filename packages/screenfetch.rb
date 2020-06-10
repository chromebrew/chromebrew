require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.9.0'
  compatibility 'all'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.9.0.tar.gz'
  source_sha256 'd6df4ef7763f9761d818c878465d78ef701b71002a50d4f150f65a31cc1bea37'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/screenfetch-3.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1a4f6205d1b5404524cd23242ebe476fb11074b72974908bd4e7250a35a3209b',
     armv7l: '1a4f6205d1b5404524cd23242ebe476fb11074b72974908bd4e7250a35a3209b',
       i686: 'f59b9a43ca298cdddfaba8fc7be3e0c4f2b172ff4c27e32e2879cafe0621cfd6',
     x86_64: 'f91a00be5514342fb734eb55ef5448f0da5c7d31538e04721f114c94625bfa15',
  })

  depends_on 'bc'

  def self.build
  end

  def self.install
    system "install -D screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
