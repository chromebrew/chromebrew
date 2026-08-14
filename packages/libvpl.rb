require 'buildsystems/cmake'

class Libvpl < CMake
  description 'Intel® Video Processing Library (Intel® VPL) API, dispatcher, and examples'
  homepage 'https://intel.github.io/libvpl/'
  version '2.17.0-1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/libvpl.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '37b60625bd80ec7ab1acb5bb271d229afbd6413dc55fff914d7603689350a5e3'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libdrm' => :library
  depends_on 'libva' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols' => :build

  cmake_options '-DBUILD_TESTS=OFF -DINSTALL_EXAMPLE_CODE=OFF'
end
