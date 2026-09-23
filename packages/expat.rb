require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.8.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4102b4a7e73774b9f4fcf9054b00dda9cd6ce96f0920d76e7e82f59c678ad4db',
     armv7l: '4102b4a7e73774b9f4fcf9054b00dda9cd6ce96f0920d76e7e82f59c678ad4db',
       i686: '8064ff4f95f3dfbb889aded11f7fefe7d5d66f06a4d5c1ae72a973a8b0a47698',
     x86_64: '88e542ae703eaeb7384a31865da154e0330d880e19e2dacabe0e79c6b7f6eb66'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options "-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON \
          #{'-DEXPAT_DEV_URANDOM=ON' if ARCH == 'i686'}"
end
