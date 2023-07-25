require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.3.257'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.257_armv7l/vulkan_icd_loader-1.3.257-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.257_armv7l/vulkan_icd_loader-1.3.257-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.257_x86_64/vulkan_icd_loader-1.3.257-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13c0bdf67dd677f53f6c8303a847fd37a7658d32b97894661b6e69bd0b620b3c',
     armv7l: '13c0bdf67dd677f53f6c8303a847fd37a7658d32b97894661b6e69bd0b620b3c',
     x86_64: '74e39ecdadfa80bae231d995fcdfb749c25202664ecfe1718fcbc8757ca88aa0'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxrandr' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' => :build

  def self.build
    system 'scripts/update_deps.py'
    system "cmake -G Ninja -B builddir \
        #{CREW_CMAKE_OPTIONS} \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
