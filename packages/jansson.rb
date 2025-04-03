require 'buildsystems/cmake'

class Jansson < CMake
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'https://github.com/akheron/jansson'
  version '2.14.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/akheron/jansson.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc0f1fb68eb545878b69c4f947f2067034bf7671da0c12e6eea2922ec26d2c7a',
     armv7l: 'bc0f1fb68eb545878b69c4f947f2067034bf7671da0c12e6eea2922ec26d2c7a',
       i686: '17d0fce402ba1eb72c150f599e0844b51b1822f07b7dfcc013d02df1fe2a87f4',
     x86_64: 'e924bb12424fabfddc56c8515272f2af3fae693aea4361a780713079f56a813b'
  })

  depends_on 'glibc' # R

  cmake_options '-DJANSSON_BUILD_SHARED_LIBS=ON'
end
