require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.12.2'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '7ce33c2492221a0436f96a8500215e9f3e3dcb5fd26a757cd415e7a843babd5e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '955a5aeb357d74d8573b2100aeed8ca3ba474b03520941e651fa5fe944041028',
     armv7l: '955a5aeb357d74d8573b2100aeed8ca3ba474b03520941e651fa5fe944041028',
       i686: '8cf7dbbd346d80016de2c03000ceacd2d284beee5ae6b02ca96cc7b80be56ba8',
     x86_64: '677f4b0d491aae72b3cb8c223bafdeb2c836bbdd749bc4ef9732744aace24f1f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'libgpg_error' => :library

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
