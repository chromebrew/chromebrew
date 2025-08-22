# Adapted from Arch Linux vapoursynth PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/vapoursynth/trunk/PKGBUILD

require 'buildsystems/autotools'

class Vapoursynth < Autotools
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version 'R72'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa2f7446128d41bedab5a6262f7cb323a8cc2806bda29d810d3193ee3aadc693',
     armv7l: 'aa2f7446128d41bedab5a6262f7cb323a8cc2806bda29d810d3193ee3aadc693',
     x86_64: '480b057b066c2d79029c756e3294f1416a7af139f65e8abe87cd8986049c6d7d'
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
