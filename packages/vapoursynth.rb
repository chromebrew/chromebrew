# Adapted from Arch Linux vapoursynth PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/vapoursynth/trunk/PKGBUILD

require 'buildsystems/autotools'

class Vapoursynth < Autotools
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '72'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cca812c39e7bc656e6b1ae47ee7a7288da4273f7765d516dd335795f34e33bcd',
     armv7l: 'cca812c39e7bc656e6b1ae47ee7a7288da4273f7765d516dd335795f34e33bcd',
     x86_64: '892facc7a61a0026524b22a8a19246eef9b8682c98d930e9d14b439f0554fff6'
  })

  depends_on 'ffmpeg' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'graphicsmagick' => :build
  depends_on 'libass' => :build
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'tesseract' => :build
  depends_on 'zimg' # R

  autotools_configure_options '--disable-static'
end
