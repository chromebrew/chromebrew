# Adapted from Arch Linux vapoursynth PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/vapoursynth/trunk/PKGBUILD

require 'buildsystems/autotools'

class Vapoursynth < Autotools
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version 'R65'
  license ' LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '568a8c6a29d77173b9b12e83658589cc828829f9d55d27f313832fd5a99ce55a',
     armv7l: '568a8c6a29d77173b9b12e83658589cc828829f9d55d27f313832fd5a99ce55a',
     x86_64: '51bf407bc0ec1e0a731fce3f3ade991ec6fb4a13fe00f7b15afda0838dd42a03'
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

  configure_options '--disable-static'
end
