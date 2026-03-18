require 'buildsystems/cmake'

class Libfmt < CMake
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '12.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b24c4ddb0500db3386366501c7db7e0f45d4d7dd8c22d72456416930d8a6398',
     armv7l: '0b24c4ddb0500db3386366501c7db7e0f45d4d7dd8c22d72456416930d8a6398',
       i686: '2d800a7deb9582ed1890d1ec22ddfd87754047a056f47904de3ec689a4399ecc',
     x86_64: 'b48579b0d43716789899a4561cfc8e7b47666df6a40a8fb6114c07dcf55d37a2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=TRUE'
  run_tests
end
