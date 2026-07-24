require 'buildsystems/cmake'

class Libvpl < CMake
  description 'Intel® Video Processing Library (Intel® VPL) API, dispatcher, and examples'
  homepage 'https://intel.github.io/libvpl/'
  version '2023.4.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/libvpl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'e6d0a955a414876db92bd454d3ea446b33c30eba2cbf602dc3f914b1d870b1d1'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'intel_media_sdk' => :library
  depends_on 'libdrm' => :library
  depends_on 'libva' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols' => :build

  cmake_options '-DBUILD_TESTS=OFF -DINSTALL_EXAMPLE_CODE=OFF'
end
