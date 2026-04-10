require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.0.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '060b9fe2249eed1ae2ffc6bd7a229c2f88a6ba3ea3e11db75b3e12487adc94c9',
     armv7l: '060b9fe2249eed1ae2ffc6bd7a229c2f88a6ba3ea3e11db75b3e12487adc94c9',
     x86_64: '3016690590cc8a033415f0bd690cff2527327962dadf329788162b5de3b9a90c'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
