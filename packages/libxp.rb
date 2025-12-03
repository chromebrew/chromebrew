require 'buildsystems/autotools'

class Libxp < Autotools
  description 'x print service extension library'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxp'
  version '1.0.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxp.git'
  git_hashtag "libXp-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82691c9d983b86717ba3175feeb110ce70e41c14d9b9076d10b7e564da93fb67',
     armv7l: '82691c9d983b86717ba3175feeb110ce70e41c14d9b9076d10b7e564da93fb67',
       i686: 'e521d3715463b7c64987ec5a19bd54e8c7e06668b8333e38f8e052f0f6f103a7',
     x86_64: '6855b14fa9e1839f1a032856b0aad33d34ed3b581af6495ed40ab5eec1ac365e'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext'
  depends_on 'xorg_proto'
end
