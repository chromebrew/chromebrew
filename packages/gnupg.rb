require 'buildsystems/autotools'

class Gnupg < Autotools
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.4.6'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  source_sha256 '95acfafda7004924a6f5c901677f15ac1bda2754511d973bb4523e8dd840e17a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11f64f2bf8d36d22c4b12de99a5dba2e9eb471a897d2a124a7082a75569f3ce7',
     armv7l: '11f64f2bf8d36d22c4b12de99a5dba2e9eb471a897d2a124a7082a75569f3ce7',
       i686: '772375004996c7cb5837f9f0ed54d107b201db9dd099fec3c9b7ab2ee8cba9b8',
     x86_64: '5915ea7434e4a720737832fd6a21fea46baa996c2c34bab4feba437f044b971d'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libassuan' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libksba' # R
  depends_on 'libusb' # R
  depends_on 'libxtrans' => :build
  depends_on 'npth' # R
  depends_on 'openldap' # R
  depends_on 'pinentry' => :build
  depends_on 'potrace' => :build
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlib' # R

  configure_options '--with-zlib \
    --with-bzip2 \
    --with-readline'

  run_tests

  def self.patch
    downloader 'https://files.gnupg.net/file/data/zy2tsxkydxq4okdhxj4p/PHID-FILE-cnig3h7b4hnrmr5efbh2/file', '7beaf4c72dc91a885fb088f7c1ef043ab49f230666727bcf2609954d722aba36', 'unistd.patch'
    system 'patch -Np1 -i unistd.patch'
  end
end
