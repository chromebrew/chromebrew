require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://mesa.freedesktop.org/archive/mesa-#{@_ver}.tar.xz"
  source_sha256 '46c1dc5bb54a372dee43ec3c067229c299187d5bdadf1402756bbf66a6df5b88'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '535d0993748c3331486a2a48f380898244d223f355306374fd7761260871731a',
     armv7l: '535d0993748c3331486a2a48f380898244d223f355306374fd7761260871731a',
       i686: 'dd315ca82272212afa69914bc1f4a676fd0d5f1e35f7e11c1264c569afed360d',
     x86_64: '0d69570884f25ca4ea75635c05d60652148397d51afecedc92cf3dcee6955361'
  })

  depends_on 'elfutils'
  depends_on 'glslang' => :build
  depends_on 'libdrm'
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind'
  depends_on 'libvdpau' => :build
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxdamage' => :build
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxrandr'
  depends_on 'libxshmfence'
  depends_on 'libxv'
  depends_on 'libxvmc'
  depends_on 'libxxf86vm'
  depends_on 'lm_sensors'
  depends_on 'py3_mako'
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland'
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
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
