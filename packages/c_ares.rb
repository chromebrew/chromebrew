require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.19.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "cares-#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.19.1_armv7l/c_ares-1.19.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.19.1_armv7l/c_ares-1.19.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.19.1_i686/c_ares-1.19.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.19.1_x86_64/c_ares-1.19.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8c41ecb94c5552fe5e02f86c45229543497c64fa2781394d252a627442dadea3',
     armv7l: '8c41ecb94c5552fe5e02f86c45229543497c64fa2781394d252a627442dadea3',
       i686: '004494aa4e31183ab22b6e6696762ee5f890cb32a7d3d2ed437e0a3c341aec79',
     x86_64: 'e85ca9997111b55d082c5dc3a9ee12873cdd7f4d9f1523c26965d58e4feff33a'
  })

  depends_on 'glibc' # R

  cmake_options '-DCARES_STATIC=ON \
      -DCARES_STATIC_PIC=ON \
      -DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON \
      -DCARES_SHARED=ON'
end
