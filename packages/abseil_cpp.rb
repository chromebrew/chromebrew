require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20250814.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09d000e511a10a9981c5afe20ad3444888f47743f5dba6841b8f366b1ad37978',
     armv7l: '09d000e511a10a9981c5afe20ad3444888f47743f5dba6841b8f366b1ad37978',
       i686: 'faaad0820c180fd0d26f195c4d9741640a6fdb3f8e93e0618d569b8763634134',
     x86_64: '9f793aee9ea8db2a16a80b52df9ad5263f44ca0d2e262ba4efbdbfa39cb24742'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
