require 'buildsystems/cmake'

class Xsimd < CMake
  description 'C++ wrappers for SIMD intrinsics'
  homepage 'https://github.com/xtensor-stack/xsimd'
  version '14.3.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/xtensor-stack/xsimd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50882976672d53431efaa23dc62146fcab6b7268a95b920c9025fe47fdd4f7bf',
     armv7l: '50882976672d53431efaa23dc62146fcab6b7268a95b920c9025fe47fdd4f7bf',
       i686: 'c7a6341b713cde73a7c47396b41c17248bb4cc2aaa202a2a1af0a83fff3c8d1e',
     x86_64: '2b7c2da6254a29d4142c81cafbe0f1cff42766a40c85038a353b0ea84050ddce'
  })
end
