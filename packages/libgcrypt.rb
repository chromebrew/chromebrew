require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.12.4'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 'd77f68f48879510e79a2f65977ccc68981781ea0923e5bdffac2a193ea3d660e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b895c334ce68ec34856437c96dcb9bde1d852208a81ef73e8a84a402548725f8',
     armv7l: 'b895c334ce68ec34856437c96dcb9bde1d852208a81ef73e8a84a402548725f8',
       i686: '8d8d144dd4db0ee0a768ae96e90a960efff352565dda1093b09fd187203fbbda',
     x86_64: '61ae86a8bef949afdfaea8fca88c69f3e6a382def5997722436f198641469783'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgpg_error' => :library

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
