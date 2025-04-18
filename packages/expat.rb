require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.7.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '394efc3fa2f9c2c50f824a17cce76a6e05762a2292ed20355b40e193cfe6a24f',
     armv7l: '394efc3fa2f9c2c50f824a17cce76a6e05762a2292ed20355b40e193cfe6a24f',
       i686: 'b1147c02b294454066f7edb0c466e7e2c0f9caad4eeaf02b996059bc0720c756',
     x86_64: 'd6701ff3fe50aac83aa42ec62353f26245d31473a435fb721f7769cef51e5330'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
