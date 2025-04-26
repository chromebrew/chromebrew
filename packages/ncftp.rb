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
       i686: 'dca002929dba21337af416bef443cb183e4cdc914a7b00af1a098594d585b193',
     x86_64: '9bf1f556ff65f683ff892ec8d7e19841fc1f95c5750fd993b68394751652eff2'
  })

  depends_on 'glibc' # R
end
