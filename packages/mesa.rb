require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.0.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://mesa.freedesktop.org/archive/mesa-#{@_ver}.tar.xz"
  source_sha256 '379fc984459394f2ab2d84049efdc3a659869dc1328ce72ef0598506611712bb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-21.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '281a8b7b6cc4009fc39020151176e56a8f2f695c02c86fd04b81887484183a38',
     armv7l: '281a8b7b6cc4009fc39020151176e56a8f2f695c02c86fd04b81887484183a38',
       i686: 'd18cebf293137b55ba21b7daf8b015f11e787e34592b180bc3b904a8311798f9',
     x86_64: 'f82724f2890c1a8a6ceb768826cbe17301580286d47d365bbc425943af22cd6c'
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
    system 'pip3 uninstall -y Mako MarkupSafe || :'
    system "pip3 install --no-warn-script-location --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
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
