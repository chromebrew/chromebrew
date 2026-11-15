require 'buildsystems/cmake'

class Libversion < CMake
  description 'Advanced version string comparison library.'
  homepage 'https://github.com/repology/libversion'
  version '3.0.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/repology/libversion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25f71f581969e582d5e6db3941feb67eb80df9e2561e2b39afecb9ebcc91ce68',
     armv7l: '25f71f581969e582d5e6db3941feb67eb80df9e2561e2b39afecb9ebcc91ce68',
       i686: 'ad49813d8aeda0d5596ce87b8069afd845b4f8c5d76a3509781c3cf07b61945d',
     x86_64: 'a2e15327f41d110828ca8ff9e9084a05a341073acbf09b79d211ba5c7382bea0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
