require 'buildsystems/cmake'

class Audaspace < CMake
  description 'A high level and feature rich audio library written in C++ with language bindings.'
  homepage 'https://github.com/audaspace/audaspace'
  version '1.8.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/audaspace/audaspace.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc777ccb60695a4388c44ae0ff04efbad4668ce6b0391c313e840e1534425fb1',
     armv7l: 'fc777ccb60695a4388c44ae0ff04efbad4668ce6b0391c313e840e1534425fb1',
     x86_64: '3c707d185f52a49a4ab7a3b33b7a1c5d574585498ff7a59edb9506fe1ef3bc0b'
  })

  depends_on 'ffmpeg' # R
  depends_on 'fftw' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jack' # R
  depends_on 'libsndfile' # R
  depends_on 'openal' # R
  depends_on 'openblas' => :build
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_numpy' => :build
  depends_on 'python3' # R
  depends_on 'rubberband' # R
  depends_on 'sdl2' # R

  # audaspace needs the single-precision build of fftw, which we do not provide.
  cmake_options '-DBUILD_DEMOS=FALSE -DWITH_FFTW=FALSE'
end
