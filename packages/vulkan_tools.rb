# Adapted from Arch Linux vulkan-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-tools/trunk/PKGBUILD

require 'buildsystems/cmake'

class Vulkan_tools < CMake
  description 'Vulkan Utilities and Tools'
  homepage 'https://www.khronos.org/vulkan/'
  version '1.3.275'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Tools.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.275_armv7l/vulkan_tools-1.3.275-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.275_armv7l/vulkan_tools-1.3.275-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.275_x86_64/vulkan_tools-1.3.275-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dca98a388f97544eae859aca495c5f9a6ca85534e51421084b1b94b5ad941292',
     armv7l: 'dca98a388f97544eae859aca495c5f9a6ca85534e51421084b1b94b5ad941292',
     x86_64: '15e5d8dedfffc534102a0a93924d652b96a92bed650da0cde2bb7358e5c41947'
  })

  depends_on 'gcc_dev' => :build
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
        -DBUILD_ICD=OFF \
        -DUPDATE_DEPS=ON"
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
        -DBUILD_ICD=OFF \
        -DUPDATE_DEPS=ON"
    system "#{CREW_NINJA} -C builddir"
    system "#{CREW_NINJA} -C builddir-wayland"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.install 'builddir-wayland/cube/vkcube-wayland', "#{CREW_DEST_PREFIX}/bin/vkcube-wayland", mode: 0o755
  end
end
