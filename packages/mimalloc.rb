require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.7.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1f83e324f4513d2bfaa91058748f72e8de471634964e4d8a8af2595d1b6cf56',
     armv7l: 'd1f83e324f4513d2bfaa91058748f72e8de471634964e4d8a8af2595d1b6cf56',
       i686: '33e3dfd99e6e5f0a906566f68347864ad04bbae9f5f202ded96310b1fcf7d4c6',
     x86_64: '7de817c28737625e645c4959529b03a40a7e80087136c831a0a437be86161316'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
