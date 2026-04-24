require 'buildsystems/cmake'

class Chromaprint < CMake
  description 'Chromaprint is a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.'
  homepage 'https://acoustid.org/chromaprint'
  version '1.6.0'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/acoustid/chromaprint.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ec5001fb45e2c2c422c1237459649c4ba030af3391927d20f9bb92f115f555e',
     armv7l: '0ec5001fb45e2c2c422c1237459649c4ba030af3391927d20f9bb92f115f555e',
     x86_64: '8dd5d84eecb9076122aa19f63e324c5fbc97e9bd97809f1f849e93f3637ed802'
  })

  depends_on 'ffmpeg' => :library
  depends_on 'fftw' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libvpx' => :library

  cmake_options '-DBUILD_TOOLS=ON -DBUILD_TESTS=ON'
end
