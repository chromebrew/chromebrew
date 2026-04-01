require 'buildsystems/cmake'

class Utf8proc < CMake
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.11.3'
  license 'MIT and custom'
  compatibility 'all'
  source_url 'https://github.com/JuliaStrings/utf8proc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '952c6b38ab87eb980e3c0816f01491a247cef6ce773a15f85324d77f6e108eb3',
     armv7l: '952c6b38ab87eb980e3c0816f01491a247cef6ce773a15f85324d77f6e108eb3',
       i686: 'a7148852ecea9ac7522ec0fb588c8784ef8fda8d6d4ca2c0b953492c008ff621',
     x86_64: 'd81d3055e7b6256f83ebecd4682b35a240241a26191e3d28d72c505dc1ab8ffc'
  })

  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
