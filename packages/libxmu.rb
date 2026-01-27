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
    aarch64: '98bb6518a8d1f00c0ce60cd9059ce5e8922e4a299d0aa6756587db4b93b21916',
     armv7l: '98bb6518a8d1f00c0ce60cd9059ce5e8922e4a299d0aa6756587db4b93b21916',
     x86_64: '1cb7c473758970c2cb4979e6d96748ece9c9656e27ad5315f021467b1976bfcf'
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

  def self.patch
    patches = [
      # Fix for https://gitlab.freedesktop.org/xorg/lib/libxmu/-/issues/3
      ['https://gitlab.freedesktop.org/xorg/lib/libxmu/-/commit/3d207f8600adbc8fad6f5a5daaa66bf3961d9bdd.patch', 'b0379e234646e01b4d01bfefd6fe19bfa4b3f36668ebc29bf622aad615917084']
    ]
    ConvenienceFunctions.patch(patches) if ARCH != 'x86_64' && version == '1.3.0'
  end

  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
