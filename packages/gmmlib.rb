require 'buildsystems/cmake'

class Gmmlib < CMake
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  version '22.10.1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '057cf6746d6cf5093b1717893fa6ac4336fab8d92a1eb33cdfe7f6617e37ada5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libva' => :build

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5.0 -DRUN_TEST_SUITE=OFF'
end
