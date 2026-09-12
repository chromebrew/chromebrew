require 'buildsystems/cmake'

class Gmmlib < CMake
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  version '22.10.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '6433614f65fe23445a1545257553e118522cbc3acc432c28ed322db8be433f26'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libva' => :build

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5.0 -DRUN_TEST_SUITE=OFF'
end
