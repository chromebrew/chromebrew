require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.12.0'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '0311454e678189bad62a7e9402a9dd793025efff6e7449898616e2fc75e0f4f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4159c1ad66fabb3db314f97c94f986b5195c357c313eaca916af5e6e3e06b95b',
     armv7l: '4159c1ad66fabb3db314f97c94f986b5195c357c313eaca916af5e6e3e06b95b',
       i686: 'ecc138567f57120938ff9e267f29ea3487684eeb01bcfc91d873ecaa6f50b7e1',
     x86_64: '8c2c775817ea36f9863be6604755bea8c25600df65d1323b02924d409dcc83bf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgpg_error' # R

  autotools_configure_options '--enable-static \
      --enable-shared'
  run_tests
end
