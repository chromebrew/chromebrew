require 'buildsystems/cmake'

class Utf8proc < CMake
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.12.0'
  license 'MIT and custom'
  compatibility 'all'
  source_url 'https://github.com/JuliaStrings/utf8proc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8aaa528836baa86ddc4e1dc69cab00beb4f381a7a81b0c3b27a28261f92c6d2',
     armv7l: 'b8aaa528836baa86ddc4e1dc69cab00beb4f381a7a81b0c3b27a28261f92c6d2',
       i686: '7dd558087dd9427557611930c4b10513e220d27ecaf3736ff02c9ed552a4e618',
     x86_64: '978112e596dba86812b6452fa6ebfe513d4ed273379dfa045da8b7dccb8c67ca'
  })

  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
