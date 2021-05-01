require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.0.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://mesa.freedesktop.org/archive/mesa-#{@_ver}.tar.xz"
  source_sha256 '565c6f4bd2d5747b919454fc1d439963024fc78ca56fd05158c3b2cde2f6912b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.0.3_armv7l/mesa-21.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.0.3_armv7l/mesa-21.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.0.3_i686/mesa-21.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.0.3_x86_64/mesa-21.0.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '48a476c2125b18e667f9d4bf7ff62cd01f316960702c64004a7ec77e1800d538',
     armv7l: '48a476c2125b18e667f9d4bf7ff62cd01f316960702c64004a7ec77e1800d538',
       i686: '38d87df4433017a000a2c446ea2a0a17ac7db9f5aecb158fc7f1cd2115ccc4bb',
     x86_64: 'fc5692ca5514fbbcb87a7bd8cb3f1388a322830103e108350ae56cb5747f6be4'
  })

  depends_on 'elfutils' # R
  depends_on 'expat' # R
  depends_on 'gcc11' # R
  depends_on 'glibc' # R
  depends_on 'glslang' => :build
  depends_on 'libdrm' # R
  depends_on 'libgcc_s1' # R
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind' # R
  depends_on 'libvdpau' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxdamage' => :build
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxrandr' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxvmc' # R
  depends_on 'libxv' # R
  depends_on 'libxxf86vm' # R
  depends_on 'llvm' # R
  depends_on 'lm_sensors' # R
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build

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
