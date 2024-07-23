require 'buildsystems/cmake'

class Libmaxminddb < CMake
  description 'C library for the MaxMind DB file format.'
  homepage 'https://maxmind.github.io/libmaxminddb/'
  version '1.10.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/maxmind/libmaxminddb.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7a5d8d87fb90b9ad90f653afc25e0cf22e39ee68165315035273def178002e3',
     armv7l: 'b7a5d8d87fb90b9ad90f653afc25e0cf22e39ee68165315035273def178002e3',
       i686: '45cf1073e286d4c5ba40b1fd20fd861827fde48e8826df06bb6cf6f22a0385eb',
     x86_64: '14fd9c46f2a7b1b299d03b156cacad5efd47bca6683f5488a93353fa544b4189'
  })

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  run_tests
end
