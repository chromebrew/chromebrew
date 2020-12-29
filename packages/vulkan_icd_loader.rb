require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  version '1.2.165'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader/archive/v1.2.165.tar.gz'
  source_sha256 'cee0bca20c1665d944bdb310795e92401062228012f503e0b89d1ca5ac9a85d2'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.165-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.165-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.165-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.165-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '111892eecd85e7df76077ba8dd3856da3da6f33b733fa29fb01aa468e954d84e',
      armv7l: '111892eecd85e7df76077ba8dd3856da3da6f33b733fa29fb01aa468e954d84e',
        i686: 'ecdd392d03a787e2196201247cd46412accea070a13d79f2eb00ffa452d64ff1',
      x86_64: '067011ff594dff5c3fff6b4bc32d0275656d685011fcf498c93b5b78a55b8198',
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
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On \
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
