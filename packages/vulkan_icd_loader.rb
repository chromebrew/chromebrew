# Adapted from Arch Linux vulkan-icd-loader PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-icd-loader/trunk/PKGBUILD

require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  version '1.2.153-2'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader/archive/v1.2.153.tar.gz'
  source_sha256 '5fb906b2dc968f2256f2d09b093ec8cc7f19812d656c649de8ed709a6da63d4a'

  depends_on 'libx11'
  depends_on 'libxrandr'
  depends_on 'vulkan_headers'
  depends_on 'libx11' => ':build'
  depends_on 'libxrandr' => ':build'
  depends_on 'wayland' => ':build'
  depends_on 'vulkan_headers' => ':build'
  depends_on 'llvm' => ':build'

  def self.build
      ENV['CC'] = 'clang'
      ENV['CXX'] = 'clang'
      system 'mkdir build'
      Dir.chdir ('build') do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On \
        -DCMAKE_BUILD_TYPE=Release \
        .. && make"
        end
  end

  def self.install
    Dir.chdir ('build') do
      system 'make',
      "DESTDIR=#{CREW_DEST_DIR}",
      'install'
      end
  end
end
