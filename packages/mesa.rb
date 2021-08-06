require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
  git_hashtag "mesa-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.2.0_armv7l/mesa-21.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.2.0_armv7l/mesa-21.2.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.2.0_x86_64/mesa-21.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd80e1bde346c0460a377a11ead1f5b30c34369c84e124060f9a025a985bb37b3',
     armv7l: 'd80e1bde346c0460a377a11ead1f5b30c34369c84e124060f9a025a985bb37b3',
     x86_64: 'e25ae34492f5da8da9fdcb39b159f0be43b72f9b6420ec03df04cedba7493a23'
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
  #depends_on 'libva' => :build # Enable only during build to avoid circular dep.
  depends_on 'llvm' => :build
  depends_on 'lm_sensors' # R
  depends_on 'py3_mako'
  depends_on 'valgrind' => :build
  unless ARCH == 'i686' depends_on 'vulkan_headers' => :build
  unless ARCH == 'i686' depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  def self.patch
    case ARCH
    when 'aarch64', 'armv7l'
      # See https://gitlab.freedesktop.org/mesa/mesa/-/issues/5067
      @freedrenopatch = <<~PATCHEOF
                --- a/src/gallium/drivers/freedreno/freedreno_util.h   2021-08-05 14:40:22.000000000 +0000
                +++ b/src/gallium/drivers/freedreno/freedreno_util.h   2021-08-05 19:52:53.115410668 +0000
                @@ -44,6 +44,15 @@
                 #include "adreno_pm4.xml.h"
                 #include "disasm.h"
        #{'         '}
                +#include <unistd.h>
                +#include <sys/syscall.h>
                +
                +#ifndef SYS_gettid
                +#error "SYS_gettid unavailable on this system"
                +#endif
                +
                +#define gettid() ((pid_t)syscall(SYS_gettid))
                +
                 #ifdef __cplusplus
                 extern "C" {
                 #endif
      PATCHEOF
      IO.write('freedreno.patch', @freedrenopatch)
      system 'patch -Np1 -i freedreno.patch'
      # system "sed -i 's/-Werror=implicit-function-declaration/-Wno-error=implicit-function-declaration/g' meson.build"
    end
  end

  def self.build
    case ARCH
    when 'i686'
      @vk = 'intel,swrast'
      @galliumdrivers = 'swrast,svga,virgl,swr,lima,zink'
    when 'aarch64', 'armv7l'
      @vk = 'auto'
      @galliumdrivers = 'auto'
    when 'x86_64'
      @vk = 'auto'
      @galliumdrivers = 'r300,r600,radeonsi,nouveau,virgl,svga,swrast,iris,crocus'
    end
    system "meson #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    -Dvulkan-drivers=#{@vk} \
    -Dgallium-drivers=#{@galliumdrivers} \
    -Dprefer-crocus=true \
     builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
