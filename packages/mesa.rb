require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://mesa.freedesktop.org/archive/mesa-#{@_ver}.tar.xz"
  source_sha256 '0128f10e22970d3aed3d1034003731f94623015cd9797c07151417649c1b1ff8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.1.0_armv7l/mesa-21.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.1.0_armv7l/mesa-21.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.1.0_i686/mesa-21.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.1.0_x86_64/mesa-21.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9c463844ab7266af05b5f2a75490cb265d0e9c7113f6b668bac028560e294476',
     armv7l: '9c463844ab7266af05b5f2a75490cb265d0e9c7113f6b668bac028560e294476',
       i686: '2be5429a5391da110a2985c402c0931a9c8b41a39d7d4a65451c7f995586de83',
     x86_64: 'f34ac6bec705a7ea859f4d95b990829c98b19abb7eb60b4a1035f1574d841735'
  })

  depends_on 'elfutils' # R
  depends_on 'expat' # R
  depends_on 'gcc11' => :extract "#{CREW_LIB_PREFIX}/libgcc_s.so.1"
  depends_on 'glibc' # R
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
