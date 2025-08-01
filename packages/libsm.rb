require 'buildsystems/autotools'

class Libsm < Autotools
  description 'X.org X Session Management Library'
  homepage 'https://www.x.org/wiki/'
  version '1.2.6'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libsm.git'
  git_hashtag "libSM-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63dbc08e85a3feaeffeb0e740aa04dc60a8cd0e64921dc082d3d5082224c301b',
     armv7l: '63dbc08e85a3feaeffeb0e740aa04dc60a8cd0e64921dc082d3d5082224c301b',
     x86_64: '99b718f764e99b76ffa64b8bc92a5d061a3d1d38a40148eae2546a1f61d80fe1'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libx11' => :build
  depends_on 'libxtrans' => :build
  depends_on 'util_linux' # R
end
