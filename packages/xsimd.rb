require 'buildsystems/cmake'

class Xsimd < CMake
  description 'C++ wrappers for SIMD intrinsics'
  homepage 'https://github.com/xtensor-stack/xsimd'
  version '13.2.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/xtensor-stack/xsimd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9e142937891f08def9765129f4c44c5ebc6cea0fd21581b519556ad06e44378',
     armv7l: 'f9e142937891f08def9765129f4c44c5ebc6cea0fd21581b519556ad06e44378',
       i686: 'f43c484cefd93ed909690113dbe2aa162326aa2d0abfc36d9a8f978a3fafd991',
     x86_64: 'c12d6d3ca99426f7f9a7dcd792260dad81e16b310a74f788868258f6c87db2b1'
  })
end
