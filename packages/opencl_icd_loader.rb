require 'buildsystems/cmake'

class Opencl_icd_loader < CMake
  description 'OpenCL Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/OpenCL-ICD-Loader'
  version '2026.05.29'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-ICD-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02c902d4df8b3a58712a10a1c44f4323081a152906bfcf1f325e91a1aa52644e',
     armv7l: '02c902d4df8b3a58712a10a1c44f4323081a152906bfcf1f325e91a1aa52644e',
       i686: 'f4e3aefc62cc45b1123d63b3046dac959bbdb0514376a31fbdc2c2edb2388e85',
     x86_64: 'ee654e55988429a68abdf7418f290e26d80dabc798f830f754b51319c77ecd93'
  })

  depends_on 'glibc' => :library
  depends_on 'opencl_headers' => :build

  cmake_options '-DOPENCL_ICD_LOADER_BUILD_TESTING=ON'

  run_tests
end
