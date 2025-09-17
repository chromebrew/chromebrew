require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.11.2'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '6ba59dd192270e8c1d22ddb41a07d95dcdbc1f0fb02d03c4b54b235814330aac'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3084b4d1869a8ff6d5daa76dcf9451378795fdac5af9182bda7a0a7b9d4f079c',
     armv7l: '3084b4d1869a8ff6d5daa76dcf9451378795fdac5af9182bda7a0a7b9d4f079c',
       i686: '85c818af47cfe64df3acab5e5e1e54a5ad98ce3495e6cf3d703568222b0d196d',
     x86_64: 'cd0fb26e325aebc496d8b539f2f6b6744446b49caa1b34d9a1d5061b7dd502e9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgpg_error' # R

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
