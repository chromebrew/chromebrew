require './lib/package'

class Binutils < Package
  version '2.12'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/u3cp7mpdyfx99ij/binutils-2.23.2-chromeos-i686.tar.gz?token_hash=AAGsFB9HXNb5tSAm_Wd2GyIUL59BkZYgMTHkj4CkHLxggg&dl=1'
  })
  binary_sha1 ({
    i686: 'a7edc9bdaf9fc72112fe6b370f158a9a1aee87ac'
  })
  source_url "http://xd.xd/"
end
