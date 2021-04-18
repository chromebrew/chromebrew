require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.23'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch/archive/2.23.tar.gz'
  source_sha256 'b61997ec6229b2cb22b7121d0b666da91e524e212d126f55cd939d230daa5887'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/urlwatch-2.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/urlwatch-2.23-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/urlwatch-2.23-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/urlwatch-2.23-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8b23e4d28741b7d0287be81957a599fad546b048fd66b8a4b7e71a53a27c678e',
     armv7l: '8b23e4d28741b7d0287be81957a599fad546b048fd66b8a4b7e71a53a27c678e',
       i686: '5f4be490ff9b44052563617a9085ab4e9c861cbe33f059626b6e00a5d321b549',
     x86_64: '48f21d5770116a5fb650b6d3c7c860172653ddfbb0209485ee250422f69e259e'
  })

  def self.install
    system "CRYPTOGRAPHY_DONT_BUILD_RUST=1 pip3 install \
           --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -r requirements.txt"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
