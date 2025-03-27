require 'buildsystems/cmake'

class Libmaxminddb < CMake
  description 'C library for the MaxMind DB file format.'
  homepage 'https://maxmind.github.io/libmaxminddb/'
  version '1.12.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/maxmind/libmaxminddb.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: '91dd3ff1f16305f5f207143495a1701e2614ca83afe249a75393d9763439ee86',
     x86_64: '8718162376f822ddf7b27a2b4bd1aa4588faab64ede35a2b4523c82255b06c7f'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
  run_tests
end
