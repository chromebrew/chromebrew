require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.8.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b9fc42e76841c70b8da79578d0c1ec04d27b61e3faa13853cbad6620f37c05f',
     armv7l: '3b9fc42e76841c70b8da79578d0c1ec04d27b61e3faa13853cbad6620f37c05f',
       i686: '027b4892b75441b984cb9471e901b4b089974528942a4a097b8bcda9141a3f1b',
     x86_64: '9529109a080227f9872e039a0c819c93375b72630b984ffdf44de23aea754581'
  })

  depends_on 'glibc' => :library
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
