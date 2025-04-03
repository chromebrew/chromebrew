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
    aarch64: '934cd7813f9a0c8ad07c967f0d65de05a545d697cc10c6a270c09e6dbbdf30df',
     armv7l: '934cd7813f9a0c8ad07c967f0d65de05a545d697cc10c6a270c09e6dbbdf30df',
       i686: '3a4c91fbfd2b20b52174e9dfb28b16d1ed22767af66379711e1da77ac9ec9e86',
     x86_64: '224290a4b9c5e4361d7a41171745ec02211281582af9a6f7aa0b7de47a06b7de'
  })

  cmake_options '-DJANSSON_BUILD_SHARED_LIBS=ON'
end
