require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '21.3.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.3.5_armv7l/mesa-21.3.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.3.5_armv7l/mesa-21.3.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.3.5_i686/mesa-21.3.5-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/21.3.7_x86_64/mesa-21.3.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '21a732fc08bba3dc19bceffe5cc2d315de32ffd519cb8603fc338cf05946bdda',
     armv7l: '21a732fc08bba3dc19bceffe5cc2d315de32ffd519cb8603fc338cf05946bdda',
       i686: '598d0f51d38217f0846181aae988c13ca5b4f2869ea6de715210e14082b07bcd',
    x86_64: 'b08114d79bb35c52f309224d3aa0a3d7c4497d1db8aa1f0101e65a6a24870877'
  })
  git_hashtag "mesa-#{@_ver}"

  depends_on 'glslang' => :build
  depends_on 'libdrm' # R
  depends_on 'libglvnd'
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind'
  depends_on 'libvdpau' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxdamage' => :build
  depends_on 'libxdmcp' => :build
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxrandr' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxv' => :build
  depends_on 'libxvmc' # R
  depends_on 'libxv' # R
  depends_on 'libxxf86vm' # R
  # depends_on 'libva' => :build # Enable only during build to avoid circular dep.
  depends_on 'llvm' => :build
  depends_on 'lm_sensors' # R
  depends_on 'py3_mako'
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  def self.patch
    case ARCH
    when 'aarch64', 'armv7l'
      # See https://gitlab.freedesktop.org/mesa/mesa/-/issues/5067
      @freedrenopatch = <<~FREEDRENOPATCHEOF
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
      FREEDRENOPATCHEOF
      File.write('freedreno.patch', @freedrenopatch)
      system 'patch -Np1 -i freedreno.patch'
      # See https://gitlab.freedesktop.org/mesa/mesa/-/issues/3505
      @tegrapatch = <<~TEGRAPATCHEOF
                diff --git a/src/gallium/drivers/nouveau/nvc0/nvc0_state_validate.c b/src/gallium/drivers/nouveau/nvc0/nvc0_state_validate.c
                index 48d81f197db..f9b7bd57b27 100644
                --- a/src/gallium/drivers/nouveau/nvc0/nvc0_state_validate.c
                +++ b/src/gallium/drivers/nouveau/nvc0/nvc0_state_validate.c
                @@ -255,6 +255,10 @@ nvc0_validate_fb(struct nvc0_context *nvc0)
        #{'         '}
                          nvc0_resource_fence(res, NOUVEAU_BO_WR);
        #{'         '}
                +         // hack to make opengl at least halfway working on a tegra k1
                +         // see: https://gitlab.freedesktop.org/mesa/mesa/-/issues/3505#note_627006
                +         fb->zsbuf=NULL;
                +
                          assert(!fb->zsbuf);
                       }
      TEGRAPATCHEOF
      File.write('tegra.patch', @tegrapatch)
      system 'patch -Np1 -i tegra.patch'
    end
    # llvm 13 patch  See https://gitlab.freedesktop.org/mesa/mesa/-/issues/5455
    # & https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/13273.patch
    system 'curl -OLf https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/13273.patch'
    system 'patch -Np1 -i 13273.patch'
  end

  def self.build
    case ARCH
    when 'i686'
      @vk = 'intel,swrast'
      @galliumdrivers = 'swrast,svga,virgl,swr,lima,zink'
      @lto = CREW_MESON_FNO_LTO_OPTIONS
      @osmesa = 'false'
    when 'aarch64', 'armv7l'
      @vk = 'auto'
      @galliumdrivers = 'auto'
      @lto = CREW_MESON_OPTIONS
      @osmesa = 'false'
    when 'x86_64'
      @vk = 'auto'
      @galliumdrivers = 'r300,r600,radeonsi,nouveau,virgl,svga,swrast,iris,crocus'
      @lto = CREW_MESON_OPTIONS
      @osmesa = 'true'
    end
    system "meson #{@lto} \
    -Db_asneeded=false \
    -Dvulkan-drivers=#{@vk} \
    -Dgallium-drivers=#{@galliumdrivers} \
    -Dprefer-crocus=true \
    -Dosmesa=#{@osmesa} \
    -Dglvnd=true \
     builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/dri") do
      FileUtils.ln_s '.', 'tls' unless File.exist?('tls')
    end
    return unless ARCH == 'x86_64'

    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/gbm/tls"
    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/gbm/tls") do
      FileUtils.ln_s '../../libgbm.so', 'i915_gbm.so'
    end
  end
end
