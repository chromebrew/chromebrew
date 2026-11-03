require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.6.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab9c056562acfcb14ed00dfeb1387d2c08ec4adec962b605f0f16d09eb0f4ab2',
     armv7l: 'ab9c056562acfcb14ed00dfeb1387d2c08ec4adec962b605f0f16d09eb0f4ab2',
       i686: '14e3e94040b2cad4e024e2a56a29ad4373f70dc1c02928dd92a4fadca0fc4671',
     x86_64: '4988f4ebf2e57879c9137cb3008863bac7d7db639c1a5e82705d4a3b7cd3ec10'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
