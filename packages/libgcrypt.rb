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
    aarch64: 'bac670e6614c57a9c467c059c0e5e52f3e12d882f900e0256c202d01a402fd4a',
     armv7l: 'bac670e6614c57a9c467c059c0e5e52f3e12d882f900e0256c202d01a402fd4a',
       i686: 'a5745ee7c26b23c7446d8bb8e0a30c21d1ff13681ccd6b4452d3860b57edcc91',
     x86_64: 'e33abf8a01b97d6bee3cf233eb2a734803942cf914f41d7af998f78365c15a93'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'libgpg_error' => :library

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
