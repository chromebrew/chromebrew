require 'buildsystems/autotools'

class Ncftp < Autotools
  description 'NcFTP Client (also known as just NcFTP) is a set of FREE application programs implementing the File Transfer Protocol (FTP).'
  homepage 'https://ncftp.com/ncftp/'
  version '3.3.0'
  license 'Clarified-Artistic'
  compatibility 'all'
  source_url "https://www.ncftp.com/public_ftp/ncftp/ncftp-#{version}-src.tar.gz"
  source_sha256 '38a87edd210ee662b7781a0297b0925468489ad57d867b6fadf0491d017f4167'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3321010fccdc0fc30a11c7deb914f4c9b6ce606f3e3dd191b87a9266a7ed6afc',
     armv7l: '3321010fccdc0fc30a11c7deb914f4c9b6ce606f3e3dd191b87a9266a7ed6afc',
       i686: 'a634b1f53908bcd6e0e5d161b1a66508124d63aa8e519db69e72ef05dea5890f',
     x86_64: 'ca72890ad514201b5e70d071055d5f50afcf7a3fb32ce7e3410b38550d64cdfa'
  })
end
