require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.10.3'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '8b0870897ac5ac67ded568dcfadf45969cfa8a6beb0fd60af2a9eadc2a3272aa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5266a65d899b92c2d5b5f821aafc4416b6a49f187198d1d8a647884af9b6cae',
     armv7l: 'd5266a65d899b92c2d5b5f821aafc4416b6a49f187198d1d8a647884af9b6cae',
       i686: '359b23bd4316e3726275226081215f5541267370e2b8c22d11a1c24e6614df81',
     x86_64: '52a6b584a9fcd729a7c8f4d0648e13cbafec3754c09d988e5358dd593491b69d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgpgerror' # R

  configure_options '--enable-static \
      --enable-shared'
end
