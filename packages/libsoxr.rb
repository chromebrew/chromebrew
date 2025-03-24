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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  cmake_options "-DBUILD_SHARED_LIBS=ON #{'-DLIB_SUFFIX=64' if ARCH == 'x86_64'}"
  run_tests
end
