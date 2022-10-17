# Adapted from Arch Linux vulkan-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-tools/trunk/PKGBUILD

require 'package'

class Vulkan_tools < Package
  description 'Vulkan Utilities and Tools'
  homepage 'https://www.khronos.org/vulkan/'
  version '1.3.230'
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Tools/archive/v#{version}.tar.gz"
  source_sha256 '5bb190d20ee8ae4e8dd157b686bd2d3162dc3a814b3d0625d90b1d84dd177dbb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.230_armv7l/vulkan_tools-1.3.230-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.230_armv7l/vulkan_tools-1.3.230-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.230_i686/vulkan_tools-1.3.230-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.230_x86_64/vulkan_tools-1.3.230-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'be40fe9684ff980a1e4624ec112eba844b6a58e219cf71bb6bb4f1a75667693e',
     armv7l: 'be40fe9684ff980a1e4624ec112eba844b6a58e219cf71bb6bb4f1a75667693e',
       i686: '428aadff66735013c5dfc3b392cf54055b6d9dba0f710492fe4efd1c077e3674',
     x86_64: 'fbe30a5c9296eaaaab392540792bbf729166979cc5313b2d306923fe3ec3c437'
  })

  depends_on 'libx11'
  depends_on 'wayland'
  depends_on 'python3' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'glslang' => :build
  depends_on 'spirv_tools' => :build

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
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On \
        -DBUILD_CUBE=ON \
        -DBUILD_VULKANINFO=ON \
        -DBUILD_ICD=OFF \
        .."
    end
    Dir.mkdir 'builddir-wayland'
    Dir.chdir 'builddir-wayland' do
      system "env #{CREW_ENV_OPTIONS} \
        cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_WSI_XCB_SUPPORT=OFF \
        -DBUILD_WSI_XLIB_SUPPORT=OFF \
        -DBUILD_WSI_WAYLAND_SUPPORT=On \
        -DBUILD_CUBE=ON \
        -DCUBE_WSI_SELECTION=WAYLAND \
        -DBUILD_VULKANINFO=OFF \
        -DBUILD_ICD=OFF \
        .."
    end
    system 'samu -C builddir'
    system 'samu -C builddir-wayland'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.install 'builddir-wayland/cube/vkcube-wayland', "#{CREW_DEST_PREFIX}/bin/vkcube-wayland", mode: 0o755
  end
end
