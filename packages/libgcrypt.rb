require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.12.1'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '7df5c08d952ba33f9b6bdabdb06a61a78b2cf62d2122c2d1d03a91a79832aa3c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dae4b0c147f31a1b0663c5619eebe0c0aa991e17f5d591ba0c0ca4f00c04e925',
     armv7l: 'dae4b0c147f31a1b0663c5619eebe0c0aa991e17f5d591ba0c0ca4f00c04e925',
       i686: 'e9fa488830c0e4b3be75a3bc02cdbd094aa724998ed8c739064948fd65a0a384',
     x86_64: '01d3540e95234dda997c759e9fa2525cb00037196d62ad3e3a644691015fd32c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgpg_error' # R

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
