require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.7.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e292cf125e956d87f53ccc6dd9b54b2e21f9abca58298c2f3356a6158a8dd9d',
     armv7l: '4e292cf125e956d87f53ccc6dd9b54b2e21f9abca58298c2f3356a6158a8dd9d',
       i686: 'e960f541c6d5f500618fd60b070c08b83669ff142f6d2e4c3d0bbdc7f1df373d',
     x86_64: '51b51d8a05143122359ba2197011d99e78f8158d741b599557391c73ced2a5b4'
  })

  depends_on 'glibc' => :library
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
