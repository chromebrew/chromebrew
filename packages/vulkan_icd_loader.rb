require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  @_ver = '1.2.184'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Loader/archive/v#{@_ver}.tar.gz"
  source_sha256 '61f2cae1c47f38e17b6a2e578cf247041d733a2db364d6e09f4366cc493aec73'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.184_armv7l/vulkan_icd_loader-1.2.184-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.184_armv7l/vulkan_icd_loader-1.2.184-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.184_i686/vulkan_icd_loader-1.2.184-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.184_x86_64/vulkan_icd_loader-1.2.184-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '34cad6bd4efd3ea9bc603eafdc9bccdbcabbdfb4d84966ea5f04a83bc8e30886',
     armv7l: '34cad6bd4efd3ea9bc603eafdc9bccdbcabbdfb4d84966ea5f04a83bc8e30886',
       i686: '2f30b4ec1cca15bb51369cb0de31b876d19ce6d6132ef0d7499c4530c6687df5',
     x86_64: 'bb7021c88c28ddad6587eb7bc298821cf48181f5570e44ba7eb72c1ff4317068'
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
