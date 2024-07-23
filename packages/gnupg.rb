require 'buildsystems/autotools'

class Gnupg < Autotools
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.4.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.4.tar.bz2'
  source_sha256 '67ebe016ca90fa7688ce67a387ebd82c6261e95897db7b23df24ff335be85bc6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a5fda73f4dc3c7cc17b0c6374e17408941dedc72add820f27d209343fd8991f',
     armv7l: '2a5fda73f4dc3c7cc17b0c6374e17408941dedc72add820f27d209343fd8991f',
       i686: '9e204d523d1fb4fae27fb870df06ab11535df322d2c9c5c951052826c9c6784a',
     x86_64: 'c2172f64f852c09867f4780fdef72f1ca52fdd2df9059866f8e6b8033a256460'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libassuan' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libksba' # R
  depends_on 'libusb' # R
  depends_on 'libxtrans' => :build
  depends_on 'npth' # R
  depends_on 'openldap' # R
  depends_on 'pinentry' => :build
  depends_on 'potrace' => :build
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  configure_options '--with-zlib \
    --with-bzip2 \
    --with-readline'

  run_tests
end
