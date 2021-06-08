require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.1.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://mesa.freedesktop.org/archive/mesa-#{@_ver}.tar.xz"
  source_sha256 '23b4b63760561f3a4f98b5be12c6de621e9a6bdf355e087a83d9184cd4e2825f'

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/mesa-21.1.2-chromeos-armv7l.tpxz',
     armv7l: 'file:///usr/local/tmp/packages/mesa-21.1.2-chromeos-armv7l.tpxz',
       i686: 'file:///usr/local/tmp/packages/mesa-21.1.2-chromeos-i686.tpxz',
     x86_64: 'file:///usr/local/tmp/packages/mesa-21.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '55ca672cbbc91981c60cd744bedc34dc1efd26246ebf468f3801c308a8fcd78f',
     armv7l: '55ca672cbbc91981c60cd744bedc34dc1efd26246ebf468f3801c308a8fcd78f',
       i686: '8417668f98889fcdae58f783e7b80084d74a69ec5234198f39b4179b68e1d4a9',
     x86_64: 'a1a297a96645b2c3d63cc4c9411711debb5200d43acea2f3d173b6087cb2e7b8'
  })

  depends_on 'glslang' => :build
  depends_on 'libdrm' # R
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind' => :build
  depends_on 'libvdpau' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxdamage' => :build
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxrandr' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxv' => :build
  depends_on 'libxvmc' # R
  depends_on 'libxv' # R
  depends_on 'libxxf86vm' # R
  depends_on 'llvm' # R
  depends_on 'lm_sensors' # R
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  def self.build
    case ARCH
    when 'i686'
      @vk = 'intel,swrast'
      @galliumdrivers = 'swrast,svga,virgl,swr,lima,zink'
    when 'x86_64', 'aarch64', 'armv7l'
      @vk = 'auto'
      @galliumdrivers = 'auto'
    end
    system 'pip3 uninstall -y Mako MarkupSafe || :'
    system "pip3 install --no-warn-script-location --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
    system "meson #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    -Dvulkan-drivers=#{@vk} \
    -Dgallium-drivers=#{@galliumdrivers} \
     builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
