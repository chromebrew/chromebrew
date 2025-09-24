# Adapted from Arch Linux neatvnc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/neatvnc/trunk/PKGBUILD

require 'buildsystems/meson'

class Neatvnc < Meson
  description 'Fast and neat VNC server library'
  homepage 'https://github.com/any1/neatvnc'
  version '0.10-4962e0a'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/any1/neatvnc.git'
  # git_hashtag "v#{version}"
  git_hashtag '4962e0af5d550b2c4fd34c79dbdca543f233d87c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4a0dbf10bb184aaa1af6227a7528dc960730a8780bd96734511abeb53d2be8d',
     armv7l: 'c4a0dbf10bb184aaa1af6227a7528dc960730a8780bd96734511abeb53d2be8d',
     x86_64: 'a4e61730f3859e6bfb5514385b81dd00750d7fc11b4ebe87fe36affd0792f07a'
  })

  depends_on 'aml' # R
  depends_on 'ffmpeg' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'libdrm' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'mesa' # R
  depends_on 'nettle' # R
  depends_on 'pixman' # R
  depends_on 'zlib' # R

  meson_options '-Djpeg=enabled \
    -Dtls=enabled'
end
