# Adapted from Arch Linux vulkan-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-tools/trunk/PKGBUILD

require 'package'

class Vulkan_tools < Package
  description 'Vulkan Utilities and Tools'
  homepage 'https://www.khronos.org/vulkan/'
  version '1.3.240'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Tools.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.240_armv7l/vulkan_tools-1.3.240-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.240_armv7l/vulkan_tools-1.3.240-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.240_i686/vulkan_tools-1.3.240-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.240_x86_64/vulkan_tools-1.3.240-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b3f3b0490b311b16d6d589369679ee46df7df92e9b09af1da06242a6fec1e32a',
     armv7l: 'b3f3b0490b311b16d6d589369679ee46df7df92e9b09af1da06242a6fec1e32a',
       i686: '414ecb4752b785f2328a9a52ba922554404cbc7e2dd0711b0c3b70cc24ad352c',
     x86_64: '1d42540b628e8ebcd42a83cbfe10673f203e99e80248f7b58731c679d9c86eec'
  })

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
