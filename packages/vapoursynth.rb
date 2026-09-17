require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '80'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7327d496e68ea560f1a8d7979764807a0fd4bcee0c633e2628c7f0c7ad9e77b',
     armv7l: 'd7327d496e68ea560f1a8d7979764807a0fd4bcee0c633e2628c7f0c7ad9e77b',
     x86_64: '66ef5831a6b735024ce1155bafc9aaf9daf1dd51a0fe99d1f988973d26cc8902'
  })

  depends_on 'ffmpeg' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphicsmagick' => :build
  depends_on 'libass' => :build
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :library
  depends_on 'tesseract' => :build
  depends_on 'zimg' => :library
end
