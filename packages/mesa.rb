require 'buildsystems/meson'

class Mesa < Meson
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version "25.1.2-#{CREW_LLVM_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
  git_hashtag "mesa-#{version.split('-')[0..-2].join('-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3ed92b1559bd5904d871d4e1d79729d2e0dd2cb7eb62f372bc793d405e82972',
     armv7l: 'b3ed92b1559bd5904d871d4e1d79729d2e0dd2cb7eb62f372bc793d405e82972',
     x86_64: '72f588ab00c48f294ca540fe3cc012d17ca5ebaf537ad4a560fa9ee9668fd27e'
  })

  depends_on 'elfutils' # R
  depends_on 'eudev' # R
  depends_on 'expat' # R
  depends_on 'gcc_dev' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glslang' => :build
  depends_on 'libclc' => :build
  depends_on 'libdrm' # R
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
  depends_on 'libxxf86vm' # R
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' # R
  depends_on 'lm_sensors' # R
  depends_on 'py3_mako' => :build
  depends_on 'py3_ply' => :build
  depends_on 'py3_pycparser' => :build
  depends_on 'spirv_llvm_translator' => :build
  depends_on 'spirv_tools' # R
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  meson_options "#{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
    -Db_asneeded=false \
    -Degl=enabled \
    -Dgbm=enabled \
    -Dgles1=disabled \
    -Dgles2=enabled \
    -Dglvnd=enabled \
    -Dglx=dri \
    -Dintel-clc=enabled \
    -Dllvm=enabled \
    -Dgallium-drivers='#{ARCH == 'x86_64' ? 'i915,r300,r600,radeonsi,nouveau,virgl,svga,softpipe,llvmpipe,iris,crocus,zink' : 'v3d,freedreno,etnaviv,nouveau,svga,tegra,virgl,lima,panfrost,softpipe,llvmpipe,iris,zink'}' \
    -Dvulkan-drivers='#{ARCH == 'x86_64' ? 'amd, intel, intel_hasvk, swrast' : 'auto'}' \
    -Dvideo-codecs='all'"

  meson_install_extras do
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

  def self.patch
    # Currently build is locked to use the older version of the spirv_llvm_translator.
    system "sed -i \"s#'< @0@.@1@'.format(chosen_llvm_version_major, chosen_llvm_version_minor + 1) ]#'< @0@.@1@'.format(chosen_llvm_version_major + 1, chosen_llvm_version_minor + 1) ]#\" meson.build"
  end
end
