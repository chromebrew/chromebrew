require 'buildsystems/cmake'

class Chromaprint < CMake
  description 'Chromaprint is a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.'
  homepage 'https://acoustid.org/chromaprint'
  version '1.6.2'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/acoustid/chromaprint.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58698a0703045ba0f1abec54ae6086419d9426c719c58b3a0c4e6ea2a126efdf',
     armv7l: '58698a0703045ba0f1abec54ae6086419d9426c719c58b3a0c4e6ea2a126efdf',
     x86_64: 'e14bd1ddf1258f6ebcd717815d54182102605ba1980eb4c4019feb000ac92347'
  })

  depends_on 'ffmpeg' => :library
  depends_on 'fftw' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libvpx' => :library

  cmake_options '-DBUILD_TOOLS=ON -DBUILD_TESTS=ON'
end
