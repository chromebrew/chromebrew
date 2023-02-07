require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  @_ver = '1.3.240'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.240_armv7l/vulkan_icd_loader-1.3.240-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.240_armv7l/vulkan_icd_loader-1.3.240-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.240_i686/vulkan_icd_loader-1.3.240-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.240_x86_64/vulkan_icd_loader-1.3.240-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '408b04b10b60ce62556b712231e7233516f64afba574028793770bd72d299e9f',
     armv7l: '408b04b10b60ce62556b712231e7233516f64afba574028793770bd72d299e9f',
       i686: '4285135802a87ba1673e829a7e1b0ac0c37da18e4fea164d977ef40fcf4f4b2f',
     x86_64: '61aff99407ac07e4c61b848a3ffcfabf916d515a970c7ba6c93e2acd03fc9b66'
  })

  depends_on 'libx11'
  depends_on 'libxrandr'
  depends_on 'vulkan_headers'
  depends_on 'libx11' => :build
  depends_on 'libxrandr' => :build
  depends_on 'wayland' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'glibc' # R

  def self.build
    system 'scripts/update_deps.py'
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
