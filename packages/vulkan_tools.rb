# Adapted from Arch Linux vulkan-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-tools/trunk/PKGBUILD

require 'buildsystems/cmake'

class Vulkan_tools < CMake
  description 'Vulkan Utilities and Tools'
  homepage 'https://github.com/KhronosGroup/Vulkan-Tools'
  version '1.4.354'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f6ebea812193ffb4f4bc269079c86196c44ee8cabbcc457141cf0cf5452cdd3',
     armv7l: '9f6ebea812193ffb4f4bc269079c86196c44ee8cabbcc457141cf0cf5452cdd3',
     x86_64: '3dcaad5a12f9fa2faec190101fce888176e42c4330fa6f8f69db713724b0ea52'
  })

  depends_on 'gcc_dev' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'glslang' => :build
  depends_on 'libx11' => :executable
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :executable
  depends_on 'libxcb' => :library
  depends_on 'libxrandr' => :build
  depends_on 'python3' => :build
  depends_on 'spirv_tools' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' => :executable
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols' => :build

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
    FileUtils.install 'builddir-wayland/cube/vkcube', "#{CREW_DEST_PREFIX}/bin/vkcube-wayland", mode: 0o755
  end
end
