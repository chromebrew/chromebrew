require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  @_ver = '1.2.169'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Loader/archive/v#{@_ver}.tar.gz"
  source_sha256 'e8413d6244245e5322a91fa204415115941c5396b892ef28a13152af635c5ca4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.169-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.169-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.169-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_icd_loader-1.2.169-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b5e441f3f7c9959ae0fc2a9b00bbcc4d5861068687c4174f500b3d1769f08e19',
     armv7l: 'b5e441f3f7c9959ae0fc2a9b00bbcc4d5861068687c4174f500b3d1769f08e19',
       i686: '965450506c352b43d05fe88fb2e60ebd9c0080cfd321e59f392a4f32daeddaff',
     x86_64: 'ba071a6f4a1536b5c5237270c836dd89cd0bb041567f942a71e39adaacd32d87'
  })

  depends_on 'libx11'
  depends_on 'libxrandr'
  depends_on 'vulkan_headers'
  depends_on 'libx11' => ':build'
  depends_on 'libxrandr' => ':build'
  depends_on 'wayland' => ':build'
  depends_on 'vulkan_headers' => ':build'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
        cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
