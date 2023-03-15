require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '23.0.0'
  version "#{@_ver}-llvm16"
  git_hashtag "mesa-#{@_ver}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/mesa-23.0.0-llvm16_armv7l/mesa-mesa-23.0.0-llvm16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/mesa-23.0.0-llvm16_armv7l/mesa-mesa-23.0.0-llvm16-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesa/mesa-23.0.0-llvm16_x86_64/mesa-23.0.0-llvm16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b13b0187acfffb47ac9508d48f1bfbeaadf28353732d223aba6197d0ec663548',
     armv7l: 'b13b0187acfffb47ac9508d48f1bfbeaadf28353732d223aba6197d0ec663548',
     x86_64: '1d8bbbd42c178296d7d6c4a425674ae4764e83efa852931779bc3b79bf733bf8'
  })

  depends_on 'elfutils' # R
  depends_on 'eudev' # R
  depends_on 'expat' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glslang' => :build
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind'
  depends_on 'libva' => :build # Enable only during build to avoid circular dep.
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
  depends_on 'llvm' => :build
  depends_on 'lm_sensors' # R
  depends_on 'py3_mako'
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    @gallium_drivers = ARCH == 'x86_64' ? 'i915,r300,r600,radeonsi,nouveau,virgl,svga,swrast,iris,crocus,zink' : 'auto'
    @vulkan_drivers = ARCH == 'x86_64' ? 'amd, intel, intel_hasvk, swrast' : 'auto'
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Db_asneeded=false \
      -Ddri3=enabled \
      -Degl=enabled \
      -Dgbm=enabled \
      -Dgles1=disabled \
      -Dgles2=enabled \
      -Dglvnd=true \
      -Dglx=dri \
      -Dllvm=enabled \
      -Dgallium-drivers='#{@gallium_drivers}' \
      -Dvulkan-drivers='#{@vulkan_drivers}' \
      -Dvideo-codecs='vc1dec,h264dec,h264enc,h265dec,h265enc' \
       builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # The following are hacks to keep sommelier from complaining.
    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/dri") do
      FileUtils.ln_s '.', 'tls' unless File.exist?('tls')
    end
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/gbm/tls"
    case ARCH
    when 'x86_64'
      Dir.chdir("#{CREW_DEST_LIB_PREFIX}/gbm/tls") do
        # For Intel GPUs
        FileUtils.ln_s '../../libgbm.so', 'i915_gbm.so'
        # For AMD GPUs
        FileUtils.ln_s '../../libgbm.so', 'amdgpu_gbm.so'
      end
    when 'armv7l', 'aarch64'
      Dir.chdir("#{CREW_DEST_LIB_PREFIX}/gbm/tls") do
        FileUtils.ln_s '../../libgbm.so', 'pvr_gbm.so'
      end
    end
  end
end
