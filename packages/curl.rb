require 'package'

class Curl < Package
  version '7.32.0'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/vvs612glzxrnjva/curl-7.32.0-chromeos-armv7l.tar.xz',
    i686: 'https://dl.dropboxusercontent.com/s/h3x2iiy5ibi97vr/curl-7.32.0-chromeos-i686.tar.gz?token_hash=AAETu-MnNyBTCHQbkh4O817QbNK3wRLbAP_gQhjgNyFGtw&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/u2hmmd6wfz25qnn/curl-7.32.0-chromeos-x86_64.tar.gz?token_hash=AAGHjx6ATIsDW-Xi4pNUbCMknfWUa6GGQbAquWDkH1xzgg&dl=1'
  })
  binary_sha1 ({
    armv7l: '5d974555b12b54ec47f044dc1cfe7a8ed31bb7e7',
    i686: 'af3abbae663884ed367c5b6b467ebb310052f53f',
    x86_64: '94766f554b195583040e31ce8e85846d8271ac11'
  })
end
