# Adapted from Arch Linux xorg-xset PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xset/trunk/PKGBUILD

require 'buildsystems/autotools'

class Xorg_xset < Autotools
  description 'User preference utility for X'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.2.6'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xset.git'
  git_hashtag "xset-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b0cc9861081f5ce2e677fd15781d781a8b589977cfb711fc051ea77f92fa609',
     armv7l: '2b0cc9861081f5ce2e677fd15781d781a8b589977cfb711fc051ea77f92fa609',
     x86_64: 'd6f2c2c118f9a1917fd9ec58b5ce5b43bf2180709c609b3af8998e34c001d997'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'xorg_macros' => :build

  autotools_configure_options '--without-fontcache --without-xf86misc'
end
