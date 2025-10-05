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
    aarch64: '181abca0afc296fa5dab304e80288216836baf0bffde761b613dda33ea71569a',
     armv7l: '181abca0afc296fa5dab304e80288216836baf0bffde761b613dda33ea71569a',
     x86_64: 'fe266954b81e1a3fc151a0cc63bf3538f31f72cd3f662946fe07045db4839c6b'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' => :build
  depends_on 'libxi' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
end
