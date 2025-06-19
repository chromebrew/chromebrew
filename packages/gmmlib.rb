require 'buildsystems/cmake'

class Gmmlib < CMake
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  version '22.7.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '73746485904173970cd608975011f0c91628ebdd5c68d09fd615d27327da27da'
  })

  depends_on 'libva' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5.0 -DRUN_TEST_SUITE=OFF'
end
