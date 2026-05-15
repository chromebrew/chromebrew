require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '76'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9cd3bf0e1a671aae64491d9590f1aa8602b59a514e4de40e430c07edc71b3996',
     armv7l: '9cd3bf0e1a671aae64491d9590f1aa8602b59a514e4de40e430c07edc71b3996',
     x86_64: '47372f462a5af96088d1d771cf15878b2b7e8e42debac8d9638c6532acc6b4ee'
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
end
