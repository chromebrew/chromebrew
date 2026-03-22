require 'buildsystems/autotools'

class Rgb < Autotools
  description 'X color name database'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/rgb.git'
  git_hashtag "rgb-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a5880f88f2a6f8244e60da383476b0d2d47ad11d8e8363a3dab637f0e0cc82c',
     armv7l: '8a5880f88f2a6f8244e60da383476b0d2d47ad11d8e8363a3dab637f0e0cc82c',
     x86_64: 'bc6f622d3be42f4f453626141b49984c41ec71d2932fc05ed5e2ab50bd6e74a9'
  })

  depends_on 'glibc' => :executable
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto' => :build
end
