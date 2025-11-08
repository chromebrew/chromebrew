require 'buildsystems/autotools'

class Gnupg < Autotools
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/ftp/gcrypt/gnupg/'
  version '2.5.13'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  source_sha256 '31a92aa03525d66a5834fe8ae4aad05a9ba93e99235189f4f64e78ae32f13093'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3859387a3bd0e20faf8f6f989e49871ebc7f772c3506b0d7d8db430acea7094',
     armv7l: 'c3859387a3bd0e20faf8f6f989e49871ebc7f772c3506b0d7d8db430acea7094',
       i686: '55cda9be4abda4556e9f28766dc55cd6b2515ab009b57745d456275bdd8ef77b',
     x86_64: '47ff160e79a6e3372e26ad8a7aee59679ddf5d0613cc26893de33a973356b98f'
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

  def self.postremove
    Package.agree_to_remove("#{HOME}/.gnupg")
  end
end
