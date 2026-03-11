require 'buildsystems/cmake'

class Opencl_icd_loader < CMake
  description 'OpenCL Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/OpenCL-ICD-Loader'
  version '2025.07.22'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-ICD-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d70d13dc355ab2f0776ae4bfe781d4620de3259e204c58710c3ee2571e545e8',
     armv7l: '0d70d13dc355ab2f0776ae4bfe781d4620de3259e204c58710c3ee2571e545e8',
       i686: 'ffc72d971973a57978d056f3e2b85f06ffa2632299e5dad4fe9d7be7f32101d7',
     x86_64: '0f11157feadd877d6ec72ab35aeb38cbfbe638abec95bc2bd1f4111721bde1b6'
  })

  depends_on 'glibc' # R
  depends_on 'opencl_headers' => :build

  cmake_options '-DOPENCL_ICD_LOADER_BUILD_TESTING=ON'

  run_tests
end
