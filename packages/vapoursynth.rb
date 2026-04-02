# Adapted from Arch Linux vapoursynth PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/vapoursynth/trunk/PKGBUILD

require 'buildsystems/autotools'

class Vapoursynth < Autotools
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '73'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21b0681a0f82f806e0b574e134f14c42a71c98000b09b384105c3c9f7768c3cb',
     armv7l: '21b0681a0f82f806e0b574e134f14c42a71c98000b09b384105c3c9f7768c3cb',
     x86_64: '4041bcaf9426d5de4e66618cdc9cd8a9950edf16e504235454326b9415059aa6'
  })

  depends_on 'ffmpeg' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'graphicsmagick' => :build
  depends_on 'libass' => :build
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :library
  depends_on 'tesseract' => :build
  depends_on 'zimg' => :library

  autotools_configure_options '--disable-static'
end
