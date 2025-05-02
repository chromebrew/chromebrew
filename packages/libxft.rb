require 'buildsystems/autotools'

class Libxft < Autotools
  description 'X.org X FreeType interface library'
  homepage 'https://www.x.org/wiki/'
  version '2.3.9'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/archive/individual/lib/libXft-#{version}.tar.xz"
  source_sha256 '60a25b78945ed6932635b3bb1899a517d31df7456e69867ffba27f89ff3976f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b842c29e310467395653be8f166d13381c47fb72322ee51f3a8cd34a0c72c023',
     armv7l: 'b842c29e310467395653be8f166d13381c47fb72322ee51f3a8cd34a0c72c023',
     x86_64: '0de5d34d95f7577b91e220256929a60ae1839438a95f9120bcf87cb9d3c6e055'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_macros' => :build
end
