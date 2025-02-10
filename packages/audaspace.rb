require 'buildsystems/cmake'

class Audaspace < CMake
  description 'A high level and feature rich audio library written in C++ with language bindings.'
  homepage 'https://github.com/audaspace/audaspace'
  version '1.5.0-4326b24'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/audaspace/audaspace.git'
  git_hashtag '4326b24b6f92f40cc330c8685b674e3dcc11c76d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f114ac95d568b97ca06dbaa14a10a8d14ccb1dfe41de481a4c1999052f25c6c0',
     armv7l: 'f114ac95d568b97ca06dbaa14a10a8d14ccb1dfe41de481a4c1999052f25c6c0',
     x86_64: 'b4966a1ff06b7070dcf08c3a1827dbd69bdd23741b91b9b51902c46efe85087f'
  })

  depends_on 'ffmpeg'
  depends_on 'fftw'
  depends_on 'jack'
  depends_on 'libsdl'
  depends_on 'libsdl2' # R
  depends_on 'libsndfile'
  depends_on 'openal'
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_numpy'
  depends_on 'python3'

  # audaspace needs the single-precision build of fftw, which we do not provide.
  cmake_options '-DBUILD_DEMOS=FALSE -DWITH_FFTW=FALSE'
end
