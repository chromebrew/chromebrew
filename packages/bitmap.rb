require 'buildsystems/autotools'

class Bitmap < Autotools
  description 'bitmap, bmtoa, atobm - X bitmap (XBM) editor and converter utilities'
  homepage 'https://gitlab.freedesktop.org/xorg/app/bitmap'
  version '1.1.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/bitmap.git'
  git_hashtag "bitmap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'beba84caee248e1637c8e7cfbb77876c48fa9c6cbd453196be0f57f4622cd3c0',
     armv7l: 'beba84caee248e1637c8e7cfbb77876c48fa9c6cbd453196be0f57f4622cd3c0',
     x86_64: 'bccf4734b83cc075e168d6560c37214c30417f4c77ddb746feebbd0c5f8796b9'
  })

  depends_on 'glibc' # R
  depends_on 'libx11'
  depends_on 'libxaw'
  depends_on 'libxmu'
  depends_on 'libxt'
  depends_on 'xbitmaps'
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto'

  run_tests
end
