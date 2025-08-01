require 'buildsystems/cmake'

class Vulkan_icd_loader < CMake
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.4.323'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0544328f29d75d1aa3946cd80310b4d7f8784acb246aca5f820ccdba7e629ff',
     armv7l: 'e0544328f29d75d1aa3946cd80310b4d7f8784acb246aca5f820ccdba7e629ff',
     x86_64: 'db4189fd35a51f64ed029cf758434bdbc38ab37872c354303422d2e6e0469ca7'
  })

  depends_on 'glibc' # R
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
