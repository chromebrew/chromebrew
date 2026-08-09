require 'buildsystems/cmake'

class Vulkan_icd_loader < CMake
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.4.359'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccf4b04647fed787f57473a7e77a54409bf15dde9b0dfb75801639658e56a033',
     armv7l: 'ccf4b04647fed787f57473a7e77a54409bf15dde9b0dfb75801639658e56a033',
     x86_64: '614bc61acf22b3b38d89b59a84b05dd21a64d519467cb0a4a1268858eee9b58a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxrandr' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' => :build

  def self.patch
    # https://github.com/KhronosGroup/Vulkan-Loader/pull/1586
    system "sed -i 's/armhf/armhf|armv7l|armv8l/g' loader/CMakeLists.txt"
  end

  cmake_options "-DUPDATE_DEPS=On \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On"
end
