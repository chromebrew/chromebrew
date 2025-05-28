require 'buildsystems/autotools'

class Gnupg < Autotools
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.4.7'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  source_sha256 '7b24706e4da7e0e3b06ca068231027401f238102c41c909631349dcc3b85eb46'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '358da660d1034cd0486210638a35bd0334531555650634351695541940e207da',
     armv7l: '358da660d1034cd0486210638a35bd0334531555650634351695541940e207da',
       i686: '03f99a147bd90de24241fe2319e4137729167959e6b00d227a7b1b3d85f874f2',
     x86_64: 'e3c31805bf60a2503ab6df58ae96ebf7c22accd63d7e1fdd3bb4159ff2d4fc09'
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

  autotools_configure_options '--with-zlib \
    --with-bzip2 \
    --with-readline'

  run_tests
end
