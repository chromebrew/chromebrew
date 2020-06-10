require 'package'

class Choose < Package
  description 'make choices on the command line'
  homepage 'https://github.com/geier/choose'
  version '0.1.0'
  compatibility 'all'
  source_url 'https://github.com/geier/choose/archive/v0.1.0.tar.gz'
  source_sha256 'd09a679920480e66bff36c76dd4d33e8ad739a53eace505d01051c114a829633'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/choose-0.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/choose-0.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/choose-0.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/choose-0.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26cdefb57b3e12c1a73626879f0327aecc474289be086034c3f930d4cc51528b',
     armv7l: '26cdefb57b3e12c1a73626879f0327aecc474289be086034c3f930d4cc51528b',
       i686: 'e3db27cee1199945140e4524b9b2b4120d169190e37545015aed2cdd125def95',
     x86_64: '138d368f47682787e47e01a59090014d993e8f63ba6678a9b315640a5075cd88',
  })

  depends_on 'setuptools'

  def self.install
    system "pip install urwid --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "install -Dm755 choose #{CREW_DEST_PREFIX}/bin/choose"
  end
end
