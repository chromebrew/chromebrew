require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '74'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f96a42a9bc15b3af44077752317bc5d6e0d6be0b68ba5ac6c115a058e3130420',
     armv7l: 'f96a42a9bc15b3af44077752317bc5d6e0d6be0b68ba5ac6c115a058e3130420',
     x86_64: 'd2a8810fdfa8b43553ba9506c7f35d0c9fa0795772009b2581d4fe360c258aa2'
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
