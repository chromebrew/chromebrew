require 'buildsystems/cmake'

class Double_conversion < CMake
  description 'Efficient binary-decimal and decimal-binary conversion routines for IEEE doubles.'
  homepage 'https://github.com/google/double-conversion'
  version '3.3.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/google/double-conversion.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2a761f0d983588b469776d4b758837d8e5e94542c498c07ad3c4f7dc962857a',
     armv7l: 'e2a761f0d983588b469776d4b758837d8e5e94542c498c07ad3c4f7dc962857a',
       i686: '1f932f05055b69e9df5d8b2cc8bb31be242fd455cf1cd0d212ffdc471f677f9b',
     x86_64: '4b6280849f3dc5ef670f94f7a68514b0ed77aa088b0ecb592357bdb6d9c17267'
  })

  cmake_options '-DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=ON'
  run_tests
end
