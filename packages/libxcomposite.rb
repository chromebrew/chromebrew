require 'buildsystems/meson'

class Libxcomposite < Meson
  description 'X.org X Composite Library'
  homepage 'https://www.x.org/wiki/'
  version '0.4.7'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcomposite.git'
  git_hashtag "libXcomposite-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b09de753524e76b1f943abba77509249385ac2c0f1524bbb51070e7146946ca6',
     armv7l: 'b09de753524e76b1f943abba77509249385ac2c0f1524bbb51070e7146946ca6',
     x86_64: '961d9670c9bafeec269faffd8dff08cda2681bbfb58a1cd1a14f069412cae443'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' => :build
  depends_on 'libxfixes' => :build
end
