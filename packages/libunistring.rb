require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.4.2'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libunistring/libunistring-#{version}.tar.xz"
  source_sha256 '5b46e74377ed7409c5b75e7a96f95377b095623b689d8522620927964a41499c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f0dcf8a5a9ad7f097ab5510849fdabe06165c837b09d0f927dc1d83264dcb00',
     armv7l: '9f0dcf8a5a9ad7f097ab5510849fdabe06165c837b09d0f927dc1d83264dcb00',
       i686: 'ded2e29450f589071c091c4cbc7bbdf712ced82105c62dea5585b8394d3846ae',
     x86_64: '621b8d10ba194eaa76f46ebffa67fd78c3f4b2b2a7fd1dcb3b0d619a3413dfed'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--enable-static \
      --enable-shared'
end
