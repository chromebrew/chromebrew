require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.2.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c85eb723306bb5051035f834723b2a1e9259ff9da7b280f1697489c22025f4e',
     armv7l: '2c85eb723306bb5051035f834723b2a1e9259ff9da7b280f1697489c22025f4e',
       i686: 'e8f1cc7fce4522538fe71cd6424f4539ce463d2bd399fedea5cd91ef4cabdfba',
     x86_64: '6695192c7c5599f5c5f38b7aa3cad377a888f9854e8c2739cea346da1db69227'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
