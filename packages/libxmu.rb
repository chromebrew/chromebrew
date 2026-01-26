require 'buildsystems/autotools'
require 'convenience_functions'

class Libxmu < Autotools
  description 'X.org X interface library for miscellaneous utilities not part of the Xlib standard'
  homepage 'https://www.x.org/wiki/'
  version '1.3.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxmu.git'
  git_hashtag "libXmu-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5272195d6e4d49923a6d675be707609c6eafe2ed97c1f9f6284a982c2e1629a8',
     armv7l: '5272195d6e4d49923a6d675be707609c6eafe2ed97c1f9f6284a982c2e1629a8',
     x86_64: 'f9f3fb77836a4d4f20495394e9f333463f04cb91c1fa4f2bc5285fac430ece1c'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxt' # R
  depends_on 'util_linux' # R
  depends_on 'xorg_macros' => :build

  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
