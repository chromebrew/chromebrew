require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '81'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4fff232aa75efa9a8dba5eef69e4e6d27d47abe48f84537380592638b7a90ff',
     armv7l: 'd4fff232aa75efa9a8dba5eef69e4e6d27d47abe48f84537380592638b7a90ff',
     x86_64: 'f183a953f275eb12600907ef8e160bce8b177c44a39d9b83ed6763c3286e393e'
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
