require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.1'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libunistring/libunistring-1.1.tar.xz'
  source_sha256 '827c1eb9cb6e7c738b171745dac0888aa58c5924df2e59239318383de0729b98'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/1.1_armv7l/libunistring-1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/1.1_armv7l/libunistring-1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/1.1_i686/libunistring-1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunistring/1.1_x86_64/libunistring-1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '09608afc35eb1786fd6971351bd0bcde0c57296c43e0b8cfdfcbf8910d308935',
     armv7l: '09608afc35eb1786fd6971351bd0bcde0c57296c43e0b8cfdfcbf8910d308935',
       i686: '64f4a8775f607f477ba256aa0f1733f94176f99dfe58d55d4fc3b29bf3480cd6',
     x86_64: 'b92ce0d125d451d35b0604e8282288b9a9f6be36d8f76c88b20f9143cbcb773f'
  })

  depends_on 'glibc'

  configure_options '--enable-static \
      --enable-shared'
end
