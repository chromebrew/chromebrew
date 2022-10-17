# Adapted from Arch Linux vulkan-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-tools/trunk/PKGBUILD

require 'package'

class Vulkan_tools < Package
  description 'Vulkan Utilities and Tools'
  homepage 'https://www.khronos.org/vulkan/'
  version '1.3.231'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Tools.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.231_armv7l/vulkan_tools-1.3.231-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.231_armv7l/vulkan_tools-1.3.231-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.231_i686/vulkan_tools-1.3.231-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_tools/1.3.231_x86_64/vulkan_tools-1.3.231-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13f37edccb74c776e39097bfb9bf67793a47a0c2c930c8ff5528d45100e84c6f',
     armv7l: '13f37edccb74c776e39097bfb9bf67793a47a0c2c930c8ff5528d45100e84c6f',
       i686: 'd2421e5c49e7fe100dba833ee308d3be28cad42a9be06cf4dca6beb7dbc47f99',
     x86_64: '1578cd4a950863964659b1935232fc46ca98ab17b8559cfb4cd4488991f6cb86'
  })

  depends_on 'libx11'
  depends_on 'wayland'
  depends_on 'python3' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland_protocols' => :build
  depends_on 'glslang' => :build
  depends_on 'spirv_tools' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R

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
