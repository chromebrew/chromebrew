require 'buildsystems/cmake'

class Vulkan_icd_loader < CMake
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.3.281'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb164e28e6744801416bf7460d722cbdadbb904a2a605b5dc6f7eead717dbc48',
     armv7l: 'cb164e28e6744801416bf7460d722cbdadbb904a2a605b5dc6f7eead717dbc48',
     x86_64: 'eb718665934faa5ca2227e1fc2ec32b170be72ae77eb7dde0a6e22d118ac66ab'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxrandr' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' => :build

  def self.patch
    system 'scripts/update_deps.py'
  end

  cmake_options "-DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On"
end
