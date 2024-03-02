require 'buildsystems/cmake'

class Uchardet < CMake
  description 'uchardet is an encoding detector library, which takes a sequence of bytes in an unknown character encoding without any additional information, and attempts to determine the encoding of the text.'
  homepage 'https://www.freedesktop.org/wiki/Software/uchardet/'
  version '0.0.8'
  license 'MPL-1.1, GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/uchardet/releases/uchardet-0.0.8.tar.xz'
  source_sha256 'e97a60cfc00a1c147a674b097bb1422abd9fa78a2d9ce3f3fdcc2e78a34ac5f0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c2762a99c6e123f31781f32a99ed0419e473686cbc772d79113b96188c2e0622',
     armv7l: 'c2762a99c6e123f31781f32a99ed0419e473686cbc772d79113b96188c2e0622',
       i686: '1ad351c850d06f3d1eaf97587ef87fd2fbd0ec64488a4ec1eae7a855da2e9a14',
     x86_64: '286efea339a71f8c11f9abe429778c0433ff3f3a7801b6c7c8ef322ca9fa357b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
