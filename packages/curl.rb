require 'package'

class Curl < Package
  version '7.32.0'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/h3x2iiy5ibi97vr/curl-7.32.0-chromeos-i686.tar.gz?token_hash=AAETu-MnNyBTCHQbkh4O817QbNK3wRLbAP_gQhjgNyFGtw&dl=1'
  })
  binary_sha1 ({
    i686: 'af3abbae663884ed367c5b6b467ebb310052f53f'
  })
end
