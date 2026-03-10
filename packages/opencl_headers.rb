require 'buildsystems/cmake'

class Opencl_headers < CMake
  description 'OpenCL header files'
  homepage 'https://github.com/KhronosGroup/OpenCL-Headers'
  version '2025.07.22'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51b119085b6e69a18adb3fe7161abe8260266b1a11d305c9c684902f92eb7fa4',
     armv7l: '51b119085b6e69a18adb3fe7161abe8260266b1a11d305c9c684902f92eb7fa4',
       i686: '41ea1de6261d31385d48caf55e94819986ab201bbad1f446299ea574082792b8',
     x86_64: '7d0b762685e75ce2617145b5c6d58d4b871dfdd6f0edafeadb672e8cc98e7f6c'
  })
end
