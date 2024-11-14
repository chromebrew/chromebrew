require 'buildsystems/autotools'

class Bitmap < Autotools
  description 'bitmap, bmtoa, atobm - X bitmap (XBM) editor and converter utilities'
  homepage 'https://gitlab.freedesktop.org/xorg/app/bitmap'
  version '1.1.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/bitmap.git'
  git_hashtag "bitmap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fa77104fec12e266ab5bee7b67db8fb1ebac3e77e6dc2445ef0ecbe66cd3549',
     armv7l: '5fa77104fec12e266ab5bee7b67db8fb1ebac3e77e6dc2445ef0ecbe66cd3549',
     x86_64: 'f2e442cbbfbd6944fc4acee04f01f3b01538cdb66f8b517dfd81ebd291c28bf3'
  })

  depends_on 'libx11'
  depends_on 'libxaw'
  depends_on 'libxmu'
  depends_on 'libxt'
  depends_on 'xbitmaps'
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto'

  run_tests
end
