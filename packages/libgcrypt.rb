require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.12.3'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '98d1b0b3202d2b03fa754a35aa3cbbfcf526a3260d8d2ee213748001b1043006'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b52ad1279ce52775cb21e59b674b6698cb37e03d6a9023f1d9bfbd555607293c',
     armv7l: 'b52ad1279ce52775cb21e59b674b6698cb37e03d6a9023f1d9bfbd555607293c',
       i686: 'b0ee3a6f8e68310bbbbf49e072708a0de540739dad88fb1b34de1ee5ac472273',
     x86_64: 'a0ea51bcb98ac1d29b96ed11235b5ef2d71cbdc27d5ce196c70d9b0ee9cd1e49'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgpg_error' => :library

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
