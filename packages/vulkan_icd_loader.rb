require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  @_ver = '1.2.189'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Loader/archive/v#{@_ver}.tar.gz"
  source_sha256 '6e05f54a0c6a35625e8974f88c197b1817b2bddb253c38540ced9d2bc8132d6c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.189_armv7l/vulkan_icd_loader-1.2.189-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.189_armv7l/vulkan_icd_loader-1.2.189-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.189_i686/vulkan_icd_loader-1.2.189-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.189_x86_64/vulkan_icd_loader-1.2.189-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e28e70220fc29a11350fa81935620f6c076d1fc70a9cbb02223726bdeac404d3',
     armv7l: 'e28e70220fc29a11350fa81935620f6c076d1fc70a9cbb02223726bdeac404d3',
       i686: '58a491339f9fd7ec2fa5e608558d39a94e662acdd23cbc83783cea5a4de17026',
     x86_64: '1e768311c175fc199f46eaa0c6c2467dd97475983d9cdff2434ca2de858341c2'
  })

  depends_on 'libx11'
  depends_on 'libxrandr'
  depends_on 'vulkan_headers'
  depends_on 'libx11' => :build
  depends_on 'libxrandr' => :build
  depends_on 'wayland' => :build
  depends_on 'vulkan_headers' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env #{CREW_ENV_OPTIONS} \
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
