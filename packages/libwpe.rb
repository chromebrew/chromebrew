require 'buildsystems/meson'

class Libwpe < Meson
  description 'General-purpose library for WPE WebKit'
  homepage 'https://wpewebkit.org'
  version '1.16.2'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/WebPlatformForEmbedded/libwpe.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd56fb79ad0b2dbd584cb8d1e0fc14adafcde48059a61a5b6f274d748b2fcd151',
     armv7l: 'd56fb79ad0b2dbd584cb8d1e0fc14adafcde48059a61a5b6f274d748b2fcd151',
     x86_64: '910bf8a7b96f7d9f9d4990cc1ba4b20849785444f00537ae97b92ffc85d11563'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' => :build
  depends_on 'libxkbcommon'

end
