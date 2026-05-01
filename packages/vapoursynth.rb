require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '75'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a589a22f1fdc620ba67c394fde1d673cec84949d7e59c73126c3944a3fb4032',
     armv7l: '2a589a22f1fdc620ba67c394fde1d673cec84949d7e59c73126c3944a3fb4032',
     x86_64: '7e2f01b599316ce76b0b6cb896a8277ac37ff3a56c39c93b056e63e847ab9dfa'
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
