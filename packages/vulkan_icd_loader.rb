require 'buildsystems/cmake'

class Vulkan_icd_loader < CMake
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.4.352'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa39860c720b9c7dbe61dd65f1be1e8072337e041e529caaf310491f862ad648',
     armv7l: 'fa39860c720b9c7dbe61dd65f1be1e8072337e041e529caaf310491f862ad648',
     x86_64: 'c723f2b8f5304a55b70df9023bdd0dcbaa058908941723b9688c84fdd16c582b'
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
