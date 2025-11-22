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
    aarch64: '835cf27f1986f3ad80a2f934f294c9337d4df96f9af49d655534ad3b1f1befb7',
     armv7l: '835cf27f1986f3ad80a2f934f294c9337d4df96f9af49d655534ad3b1f1befb7',
     x86_64: 'f76c47cc84a520d4e99794132d94cb79396e615cdeffe41ecfce0da1fcd9a98d'
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
  depends_on 'sdl2' # R

  # audaspace needs the single-precision build of fftw, which we do not provide.
  cmake_options '-DBUILD_DEMOS=FALSE -DWITH_FFTW=FALSE'
end
