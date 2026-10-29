# Adapted from Arch Linux xorg-xeyes PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xeyes/trunk/PKGBUILD

require 'buildsystems/autotools'

class Xorg_xeyes < Autotools
  description 'Follow the mouse/SHAPE extension X demo'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.3.1'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xeyes.git'
  git_hashtag "xeyes-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9d69b2ea2769cf4e1080efc0c6b27e5067cf102f0790c56befabf8520ed19a0',
     armv7l: 'c9d69b2ea2769cf4e1080efc0c6b27e5067cf102f0790c56befabf8520ed19a0',
     x86_64: '223a2989cfaa8d20a2a69babb108ba10076a319e338a50eaa412ec3d5a616d7c'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxfixes' => :build
  depends_on 'libxi' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'libxt' => :executable
  depends_on 'xorg_macros' => :build
end
