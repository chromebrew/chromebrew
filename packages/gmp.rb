require './lib/package'

class Gmp < Package
  version "5.1.2"
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/9cwila1kaomsyl2/gmp-5.1.2-chromeos-i686.tar.gz?token_hash=AAHO9VxBpvXU2GPWBwimsp4hL8DADIItfNnIaFbfcyynMg&dl=1"
  })
  binary_sha1 ({
    i686: "b03b9508463588bfe9d09303c0725068cddd8810"
  })
end
