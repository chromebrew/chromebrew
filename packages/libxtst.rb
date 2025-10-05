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
    aarch64: 'a44455fc4e851f8b7e876e158f4602fb10ab7181aad7813e484005121f31eae4',
     armv7l: 'a44455fc4e851f8b7e876e158f4602fb10ab7181aad7813e484005121f31eae4',
     x86_64: '2169135a37e04d3bcb39449423acbf56253a46bfa1bc08d204bf2a781e783c75'
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
