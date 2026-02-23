require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.4.1-1'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libunistring/libunistring-#{version.split('-').first}.tar.xz"
  source_sha256 '67d88430892527861903788868c77802a217b0959990f7449f2976126a307763'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4336d9190de3b771a290273ec350cf785c610f92e2838ada3a4ed04a84855a47',
     armv7l: '4336d9190de3b771a290273ec350cf785c610f92e2838ada3a4ed04a84855a47',
       i686: '84637e3ff5452e9fa8efc9668618d4fa54050dfe499aa454ce01140d1e529fcc',
     x86_64: 'eea223ec748b70c1d667e078460b22e0ce91d2d87e84ec6341e330a80c31fda7'
  })

  depends_on 'glibc' # R
  depends_on 'libiconv' => :build

  autotools_configure_options '--enable-static \
      --enable-shared'
end
