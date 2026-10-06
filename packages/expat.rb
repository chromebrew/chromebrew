require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.9.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ba5d59b18a673a2b6870fbe0b8320fa06ee751a121532ac429f7f640b6c343b',
     armv7l: '2ba5d59b18a673a2b6870fbe0b8320fa06ee751a121532ac429f7f640b6c343b',
       i686: '8e1f6c6248ceb75ae07f3d7e7067074462bf2b5ccce5a098e6d65d1c9c007777',
     x86_64: '31e04a3cabd922d622894458c135493ed496d227ca56b08eaf9aa112582f83bb'
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
