require 'buildsystems/cmake'

class Xsimd < CMake
  description 'C++ wrappers for SIMD intrinsics'
  homepage 'https://github.com/xtensor-stack/xsimd'
  version '14.1.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/xtensor-stack/xsimd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd497f81cdba24b0d1a98bb275751b70370a8982b064f05c37b618647b2fb0703',
     armv7l: 'd497f81cdba24b0d1a98bb275751b70370a8982b064f05c37b618647b2fb0703',
       i686: 'c2cd6ecf8e70943d6e6a906bd795ee5db3c2795728b8f5a82648243b41ff4628',
     x86_64: 'c693e579fdd54118b4d118269a494cd96b70950ed19548ff84ff530dad11f109'
  })
end
