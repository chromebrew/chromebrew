require 'buildsystems/cmake'

class Utf8proc < CMake
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.10.0'
  license 'MIT and custom'
  compatibility 'all'
  source_url 'https://github.com/JuliaStrings/utf8proc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee20f014a0ed57e9e7c6c90b92fcbd563966813cefdcb11b905488434eeea834',
     armv7l: 'ee20f014a0ed57e9e7c6c90b92fcbd563966813cefdcb11b905488434eeea834',
       i686: '59c52de534fcbbd247bf1210987701383231356668929ad43a71bdea713290fe',
     x86_64: '5322df1f4c269ce315e898b0cc6ac95d4f3e98199e92fb192a56e2e3ddffdfb7'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
