require 'buildsystems/cmake'

class Libsoxr < CMake
  description 'High quality, one-dimensional sample-rate conversion library.'
  homepage 'https://sourceforge.net/projects/soxr/'
  version '0.1.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/soxr/soxr-#{version}-Source.tar.xz"
  source_sha256 'b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3a999ee35bd6a46e97991c23ac12c41739c2f7255c85d2f852addb8038ed54a',
     armv7l: 'b3a999ee35bd6a46e97991c23ac12c41739c2f7255c85d2f852addb8038ed54a',
       i686: '7aa70360f89debecb43d4d6e76859f392a45a38a9c0bb167197038ef40511dbe',
     x86_64: 'd7931a4f8a20e45a1880ad0e33b42b39385d0e86067d52d5e805184c51145023'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DBUILD_SHARED_LIBS=ON #{'-DLIB_SUFFIX=64' if ARCH == 'x86_64'}"
  run_tests
end
