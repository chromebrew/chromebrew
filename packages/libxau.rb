require 'buildsystems/autotools'

class Libxau < Autotools
  description 'xau library for libX11'
  homepage 'https://x.org/wiki/'
  version '1.0.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxau.git'
  git_hashtag "libXau-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2d4b68dad1338995d5e858b83532a7329a4ffc99203ff0ba820ce022c6d4858',
     armv7l: 'd2d4b68dad1338995d5e858b83532a7329a4ffc99203ff0ba820ce022c6d4858',
       i686: 'c1f87fde13a850c3ccf7116d7d5648642eafd6b32047a9962ec08726b04f4d70',
     x86_64: '6adc15c51c5e1c26c9a1d728a2370a1578faba40a74cbee925a181d01f939aa6'
  })

  depends_on 'glibc' # R
  depends_on 'xorg_proto'

end
