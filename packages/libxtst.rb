require 'buildsystems/autotools'

class Libxtst < Autotools
  description 'X.org Xtst Library'
  homepage 'http://t2sde.org/packages/libxtst.html'
  version '1.2.6'
  license 'x11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxtst.git'
  git_hashtag "libXtst-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd99c41c256e715147fbda00c8502d2407ddb3a71d811a4c5a2967d65d6f3a056',
     armv7l: 'd99c41c256e715147fbda00c8502d2407ddb3a71d811a4c5a2967d65d6f3a056',
     x86_64: '50dc23fa36f0ea99756b3828600bf869b17209156d43056857a679acace87980'
  })

  depends_on 'fop' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :build
  depends_on 'libxi' => :library
  depends_on 'libxslt' => :build
  depends_on 'xmlto' => :build
end
