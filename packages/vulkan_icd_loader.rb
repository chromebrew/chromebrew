require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  @_ver = '1.2.200'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.199_armv7l/vulkan_icd_loader-1.2.199-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.199_armv7l/vulkan_icd_loader-1.2.199-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.199_i686/vulkan_icd_loader-1.2.199-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.2.199_x86_64/vulkan_icd_loader-1.2.199-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e7219c181b2952edb9a11303a75d34f15d653a70d86b9b33ba6f4f40f92fa87c',
     armv7l: 'e7219c181b2952edb9a11303a75d34f15d653a70d86b9b33ba6f4f40f92fa87c',
       i686: '8dd3cd06b7534518ffb38bae42f972d623a62cad1bf8146ca2ca4b62598d1e1f',
     x86_64: '1e2844c6d3bd9cddb0b5d1c9154279227264214543cbb9366b66adb79539d564'
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
