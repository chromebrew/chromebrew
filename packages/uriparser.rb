require 'buildsystems/cmake'

class Uriparser < CMake
  description 'uriparser is a strictly RFC 3986 compliant URI parsing library. uriparser is cross-platform, fast, supports Unicode'
  homepage 'https://github.com/uriparser/uriparser'
  version '1.0.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/uriparser/uriparser.git'
  git_hashtag "uriparser-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b3d50b153dba52fc817a37351650bdc627aee724b41697f47b2fd1175408162',
     armv7l: '5b3d50b153dba52fc817a37351650bdc627aee724b41697f47b2fd1175408162',
       i686: 'fb296893f18f0f15fe375efa655e21a6f0b5f8fafc7cc4e054f36743b2dc3bf5',
     x86_64: '85a7352ee41d39883dd019920170bcf1b4304814dc199c042cb563b6330fb4e7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DURIPARSER_BUILD_DOCS=OFF -DURIPARSER_BUILD_TESTS=OFF'
end
