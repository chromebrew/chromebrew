# Adapted from Arch Linux libxcvt PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libxcvt/trunk/PKGBUILD

require 'buildsystems/meson'

class Libxcvt < Meson
  description 'library providing a standalone version of the X server implementation of the VESA CVT standard timing modelines generator'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxcvt'
  version '0.1.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcvt.git'
  git_hashtag "libxcvt-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '474bcf6e7fa648b98bc5d47b0816e8d37b9a0dd99accb96fb06114d3faa8c14e',
     armv7l: '474bcf6e7fa648b98bc5d47b0816e8d37b9a0dd99accb96fb06114d3faa8c14e',
       i686: '1f06226d9b6dcd098ea6569c0d582fc0f82a38918826713b8a9fc4d5aa21aa26',
     x86_64: '2597ad87332b81f1564e7062c956169b98d611f013b5a7ecf78c6de31f6646fd'
  })
end
