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
    aarch64: '9a885f9a578774f1ade3862ef02c80604c0ebd04b1ce08e02dcffae0baa1779d',
     armv7l: '9a885f9a578774f1ade3862ef02c80604c0ebd04b1ce08e02dcffae0baa1779d',
       i686: '26be9c92911051d2d9de024d6b82e1a227ad70ee27c26573a2a49c95b39bb0e6',
     x86_64: 'ec5c81a5f125b71ecefdae2e6f9adc059ae31fe531042d4be2db921772b470e8'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'lapack' => :build
  depends_on 'mpfr' => :library
  depends_on 'openblas' => :library
end
