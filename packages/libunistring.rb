require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.4.1'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libunistring/libunistring-#{version}.tar.xz"
  source_sha256 '67d88430892527861903788868c77802a217b0959990f7449f2976126a307763'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '719b717b6faffa5b081ca51034466d271d0ec21c37444321a5a26aa1f1645ac7',
     armv7l: '719b717b6faffa5b081ca51034466d271d0ec21c37444321a5a26aa1f1645ac7',
       i686: 'e0c065e55ad549ee9e5dcd48b71ab7d8b67d83a8901a83985db0e076fd84c41d',
     x86_64: '1ac48b063d98e6477745db7fc5352c9c631271fe6750ba5bee199c8820f6476f'
  })

  depends_on 'glibc'

  autotools_configure_options '--enable-static \
      --enable-shared'
end
