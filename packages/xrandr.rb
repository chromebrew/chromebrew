require 'buildsystems/autotools'

class Xrandr < Autotools
  description 'Command line interface to X11 Resize, Rotate, and Reflect (RandR) extension'
  homepage 'https://gitlab.freedesktop.org/xorg/app/xrandr'
  version '1.5.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrandr.git'
  git_hashtag "xrandr-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '244014996409b4778ed756e3bdbb313f47bb9514f19945ece8c0cc0df2c45eae',
     armv7l: '244014996409b4778ed756e3bdbb313f47bb9514f19945ece8c0cc0df2c45eae',
     x86_64: '9e69504d88e1c4598a1936483d80fb05cefeea697511f0716c46bc44c11f6054'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R

  run_tests
end
