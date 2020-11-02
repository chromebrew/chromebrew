# Adapted from Arch Linux vulkan-icd-loader PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-icd-loader/trunk/PKGBUILD

require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.2.153-2'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader/archive/v1.2.153.tar.gz'
  source_sha256 '5fb906b2dc968f2256f2d09b093ec8cc7f19812d656c649de8ed709a6da63d4a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.153-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.153-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.153-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.153-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5756b62ea74988eef3cbf9e189ded23fb826848f086b5f809309276c7556d5eb',
     armv7l: '5756b62ea74988eef3cbf9e189ded23fb826848f086b5f809309276c7556d5eb',
       i686: '0505cb5556abb969fca4378f7d16979fa38739a6804c4dce7f2e3965cea0eeb6',
     x86_64: 'f234c7327d2044847bd39d354aa0769997da8797162f2ae7b818de6b53de9a1a',
  })

  depends_on 'llvm' => ':build'
  depends_on 'libx11'
  depends_on 'libxrandr'
  depends_on 'vulkan_headers'
  depends_on 'libx11' => ':build'
  depends_on 'libxrandr' => ':build'
  depends_on 'wayland' => ':build'
  depends_on 'vulkan_headers' => ':build'

  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
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
    Dir.chdir 'build' do
      system 'make',
        "DESTDIR=#{CREW_DEST_DIR}",
        'install'
    end
  end
end
