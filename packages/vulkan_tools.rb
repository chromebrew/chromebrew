# Adapted from Arch Linux vulkan-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-tools/trunk/PKGBUILD

require 'package'

class Vulkan_tools < Package
  description 'Vulkan Utilities and Tools'
  homepage 'https://www.khronos.org/vulkan/'
  version '1.3.251'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Tools.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.251_armv7l/vulkan_tools-1.3.251-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.251_armv7l/vulkan_tools-1.3.251-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.251_x86_64/vulkan_tools-1.3.251-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '170c874b3cc837e84154d248952b6cc83fc6a46a84bfec5096d8630f7b8f70b8',
     armv7l: '170c874b3cc837e84154d248952b6cc83fc6a46a84bfec5096d8630f7b8f70b8',
     x86_64: '61db4831ab580e0c5e6f1672a9fe252fc2aa82294e7c26358d52323173046d7c'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glslang' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' => :build
  depends_on 'python3' => :build
  depends_on 'spirv_tools' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  def self.build
    system 'scripts/update_deps.py'
    system "cmake -G Ninja -B builddir \
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
        -DBUILD_ICD=OFF"
    system "cmake -G Ninja -B builddir-wayland \
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
        -DBUILD_ICD=OFF"
    system "#{CREW_NINJA} -C builddir"
    system "#{CREW_NINJA} -C builddir-wayland"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.install 'builddir-wayland/cube/vkcube-wayland', "#{CREW_DEST_PREFIX}/bin/vkcube-wayland", mode: 0o755
  end
end
