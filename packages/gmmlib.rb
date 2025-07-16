require 'buildsystems/cmake'

class Gmmlib < CMake
  description 'The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI.'
  homepage 'https://github.com/intel/gmmlib/'
  version '22.8.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/gmmlib.git'
  git_hashtag "intel-gmmlib-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '73424ec04dfc569e9d25df63719251af95b38aec3b840b9972fa951f3fdb051c'
  })

  depends_on 'libva' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5.0 -DRUN_TEST_SUITE=OFF'
end
