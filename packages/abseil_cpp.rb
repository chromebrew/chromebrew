require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20260526.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2405bafbac0153884d3514b6a5fb30b6a03fc29edc95f63b5e1f404267ff963',
     armv7l: 'a2405bafbac0153884d3514b6a5fb30b6a03fc29edc95f63b5e1f404267ff963',
       i686: 'd9aa0741924b4d37a2905ed160dd8f7eb3cd8e4dbb34fe40fd6d709b0af8061a',
     x86_64: '5d06a71cd98873472fd2432fe3cd94ffd0e238e3c0a4442fc749129d57d0f06b'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
