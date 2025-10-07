require 'buildsystems/autotools'

class Libxtst < Autotools
  description 'X.org Xtst Library'
  homepage 'http://t2sde.org/packages/libxtst.html'
  version '1.2.5'
  license 'x11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxtst.git'
  git_hashtag "libXtst-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e7bb1ac0b1374f726adb05e82daa4474182e996e591e1dd4297cccdb49299b1',
     armv7l: '8e7bb1ac0b1374f726adb05e82daa4474182e996e591e1dd4297cccdb49299b1',
     x86_64: 'baf7a556665c1fd42af7f51d539b62e067addddb62d8806fd527fb56455c2dc7'
  })

  depends_on 'fop' => :build
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' => :build
  depends_on 'libxi' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'xmlto' => :build
  depends_on 'libxslt' => :build
end
