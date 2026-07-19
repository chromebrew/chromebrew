require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.8.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be6c3784c2df447f42ccda9bbf825313780e42192b22f3af657eb052c681ea29',
     armv7l: 'be6c3784c2df447f42ccda9bbf825313780e42192b22f3af657eb052c681ea29',
       i686: '460b1fba7b1091b6c4d5e2d8225d367fbe43d8950abee2b0752bbecdf8ef38dc',
     x86_64: '7f44d48ca6af63d46afa29a64d20f5925f098d28b8ea54b8a29f062ca8f870f5'
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
