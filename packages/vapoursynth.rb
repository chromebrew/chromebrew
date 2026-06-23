require 'buildsystems/meson'

class Vapoursynth < Meson
  description 'A video processing framework with the future in mind'
  homepage 'http://www.vapoursynth.com/'
  version '77'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/vapoursynth/vapoursynth.git'
  git_hashtag "R#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e203729918a59e631733e1f30a39938f3e9a6d9da1b259b804f8d9abb019579b',
     armv7l: 'e203729918a59e631733e1f30a39938f3e9a6d9da1b259b804f8d9abb019579b',
     x86_64: 'e99445a28516b9994b0c13c4da8e2cefaf49a616e81a47bd9c41a9e7414d9130'
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
