require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '82'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ea3eb6c329f2aeb02bfa281bd1f5ab65febaaf398da2bfedf8efc768e903510',
     armv7l: '3ea3eb6c329f2aeb02bfa281bd1f5ab65febaaf398da2bfedf8efc768e903510',
     x86_64: '9af0a0e465a79f2012f89ec3a24ceaa5784d9b43db40d8ac026ae9bb44d99c8c'
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
