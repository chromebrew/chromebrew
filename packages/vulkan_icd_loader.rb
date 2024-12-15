require 'buildsystems/cmake'

class Vulkan_icd_loader < CMake
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.4.303'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4ebef246f9c8593a7c100aecaa7388a8185d8a5d620d0ad52032375efcd48dc',
     armv7l: 'd4ebef246f9c8593a7c100aecaa7388a8185d8a5d620d0ad52032375efcd48dc',
     x86_64: 'a27824a2e823bc7f42b281a64977615692ff7c9ad173cd45da63e29afa7b2d0b'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
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
