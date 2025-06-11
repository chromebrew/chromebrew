require 'buildsystems/cmake'

class Uchardet < CMake
  description 'uchardet is an encoding detector library, which takes a sequence of bytes in an unknown character encoding without any additional information, and attempts to determine the encoding of the text.'
  homepage 'https://www.freedesktop.org/wiki/Software/uchardet/'
  version '0.0.8-9699dfc'
  license 'MPL-1.1, GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/uchardet/uchardet.git'
  git_hashtag '9699dfce074fac80d8d622f02ea6d8bb2f55cf00'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60ec85e91ae02c6a6777735ea9e60fd5395dc05c891b16e5c347c9e6135b0ffa',
     armv7l: '60ec85e91ae02c6a6777735ea9e60fd5395dc05c891b16e5c347c9e6135b0ffa',
       i686: '469fda854cf14692cec6e14a8c98359c5b7132ed0bd16500026d57ba702cbf23',
     x86_64: '4f101f07fc62f24e9a2777c6f0fc4e2106979edbe45721325c299208e7e9e5f7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
