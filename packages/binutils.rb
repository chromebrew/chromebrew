require 'package'

class Binutils < Package
  version '2.23.2'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/u3cp7mpdyfx99ij/binutils-2.23.2-chromeos-i686.tar.gz?token_hash=AAGsFB9HXNb5tSAm_Wd2GyIUL59BkZYgMTHkj4CkHLxggg&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/mnu21v101rdbm8k/binutils-2.23.2-chromeos-x86_64.tar.gz?token_hash=AAEn4ngAJs-fpRUz1n1Q_2WKxQvQnPMwlgcEHBDKyLOpoA&dl=1',
    armv7l: 'https://www.dropbox.com/s/beeupftoyw3fhxo/binutils-2.25.1-armv7l.tar.gz?dl=0'
  })
  binary_sha1 ({
    i686: 'a7edc9bdaf9fc72112fe6b370f158a9a1aee87ac',
    x86_64: '1c13b8f261e419a66b87f09653f3fbaf8449efe1',
    armv7l: 'd3fd60f275a774d93202d84f3de1deb79c4f2c6a'
  })
end
