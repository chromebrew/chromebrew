require 'buildsystems/cmake'

class Chromaprint < CMake
  description 'Chromaprint is a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.'
  homepage 'https://acoustid.org/chromaprint'
  version '1.6.1'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/acoustid/chromaprint.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f7f5e99cdb6097cdd3d2ee1fa70ad85c312ba645743152a47015956627381bc',
     armv7l: '2f7f5e99cdb6097cdd3d2ee1fa70ad85c312ba645743152a47015956627381bc',
     x86_64: 'e5e5bfc4c31d06f23e3be7e197347335a92f1843263c2f30d7806f091e696313'
  })

  depends_on 'ffmpeg' => :library
  depends_on 'fftw' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libvpx' => :library

  cmake_options '-DBUILD_TOOLS=ON -DBUILD_TESTS=ON'
end
