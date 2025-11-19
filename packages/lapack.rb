require 'buildsystems/cmake'

class Lapack < CMake
  description 'Lapack is a linear algebra package.'
  homepage 'https://www.netlib.org/lapack/'
  version '3.12.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Reference-LAPACK/lapack.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48e69f2b094d33ac167a185e4d53a7ecb6146edcf14a9cf858da7362fde39656',
     armv7l: '48e69f2b094d33ac167a185e4d53a7ecb6146edcf14a9cf858da7362fde39656',
       i686: '31526ff64ea9b7f8a023ca026fb02b4805bd23ff41e57610d1cd837bc4f0a0d3',
     x86_64: 'a0bac9f30ebef219fea41cfaa9313644727226c166edd953b84278f3e07997b6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
