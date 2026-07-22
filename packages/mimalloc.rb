require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.4.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d89260ba2f4ca7209ac99f942c4f49538b21ad7f8250e7ccfbf37dad65e93cd',
     armv7l: '8d89260ba2f4ca7209ac99f942c4f49538b21ad7f8250e7ccfbf37dad65e93cd',
       i686: '71ba8d320eec65a8e572b041cb545fe4a79de0f8093af2c6827331bfc2e44bc8',
     x86_64: '2a5a85d2ef716b1de783f4763e95d2f71410e6d1349a033fa6ec03c61751fd54'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
