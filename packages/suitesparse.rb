require 'buildsystems/cmake'

class Suitesparse < CMake
  description 'A suite of sparse matrix software'
  homepage 'https://people.engr.tamu.edu/davis/suitesparse.html'
  version '7.14.0'
  license 'metapackage'
  compatibility 'all'
  source_url 'https://github.com/DrTimothyAldenDavis/SuiteSparse.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56423289c886f9451250703fb071f8df9b4e626fc598389e2f02aa8946e431e7',
     armv7l: '56423289c886f9451250703fb071f8df9b4e626fc598389e2f02aa8946e431e7',
       i686: '89f97ed14f25bd80c41d7acd53419e66c7c132997f10611da5f437148c9c1548',
     x86_64: 'b1e26049e41843da9941a6a7a2b90051d8943bafea7b8f8eb0c26b688b3958cc'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'lapack' => :build
  depends_on 'mpfr' => :library
  depends_on 'openblas' => :library
end
