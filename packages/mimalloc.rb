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
    aarch64: '2cec6c2ed76ed609639e6b2f04d4022b7f26354a6e4b89de192da4a9e60d19c6',
     armv7l: '2cec6c2ed76ed609639e6b2f04d4022b7f26354a6e4b89de192da4a9e60d19c6',
       i686: '33b04f1b3af0205493034239534624c86b121572588f7ef0aad8cfe6cf563bb4',
     x86_64: 'b2559b074a996754a18f9243f57ed2fa5561284a3908658719797f996999fe44'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
