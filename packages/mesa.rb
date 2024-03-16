require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '24.0.3'
  version "#{@_ver}-llvm18"
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
  git_hashtag "mesa-#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cef5e377b35af3c786140197d27bc485dd9515eae747e27e1c7005ca7e6da395',
     armv7l: 'cef5e377b35af3c786140197d27bc485dd9515eae747e27e1c7005ca7e6da395',
     x86_64: 'd8d8a3bbc4f529c36cc69b886586623479c8d797790f3e36e7c8b1f7639b40f3'
  })

  depends_on 'elfutils' # R
  depends_on 'eudev' # R
  depends_on 'expat' # R
  depends_on 'gcc_dev' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' #
  depends_on 'glslang' => :build
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind' # R
  depends_on 'libva' => :build
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
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'lm_sensors' # R
  depends_on 'py3_mako' => :build
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -Db_asneeded=false \
      -Ddri3=enabled \
      -Degl=enabled \
      -Dgbm=enabled \
      -Dgles1=disabled \
      -Dgles2=enabled \
      -Dglvnd=true \
      -Dglx=dri \
      -Dllvm=enabled \
      -Dgallium-drivers='#{ARCH == 'x86_64' ? 'i915,r300,r600,radeonsi,nouveau,virgl,svga,swrast,iris,crocus,zink' : 'v3d,freedreno,etnaviv,nouveau,svga,tegra,virgl,lima,panfrost,swrast,iris,zink'}' \
      -Dvulkan-drivers='#{ARCH == 'x86_64' ? 'amd, intel, intel_hasvk, swrast' : 'auto'}' \
      -Dvideo-codecs='all' \
       builddir"
    system 'meson configure --no-pager builddir'
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
