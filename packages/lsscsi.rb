require 'buildsystems/autotools'

class Lsscsi < Autotools
  description 'The lsscsi command lists information about SCSI devices in Linux.'
  homepage 'http://sg.danny.cz/scsi/lsscsi.html'
  version '0.32'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://sg.danny.cz/scsi/lsscsi-#{version}.tgz"
  source_sha256 '0a800e9e94dca2ab702d65d72777ae8cae078e3d74d0bcbed64ba0849e8029a1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c18783f57d5e4d774c089d47ce19a4084b28180e267c5a2b3f6bdbf702998a6',
     armv7l: '3c18783f57d5e4d774c089d47ce19a4084b28180e267c5a2b3f6bdbf702998a6',
       i686: 'ed007f117c7401e0fec65b3624117eda1b5a04cac0382853dbd81dba6c62f59c',
     x86_64: '3b3e228b6f3cc737ff8dc4d951ca5aea843d42ee0043cd0c90b6ba56838c3655'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
