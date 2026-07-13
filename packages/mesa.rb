require 'buildsystems/meson'

class Mesa < Meson
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version "26.1.4-#{CREW_LLVM_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
  git_hashtag "mesa-#{version.gsub("-#{CREW_LLVM_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a7092dec67889a0fcc3467e4c87d20456292ad1201e5afb66138ca7b00bf041',
     armv7l: '3a7092dec67889a0fcc3467e4c87d20456292ad1201e5afb66138ca7b00bf041',
     x86_64: '07c6cd070d197625a9f0196698db6f04888bfe6815bca5c407ef97ddb1d2c95f'
  })

  depends_on 'elfutils' => :library
  depends_on 'eudev' => :library
  depends_on 'expat' => :library
  depends_on 'gcc_dev' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glslang' => :build
  depends_on 'libclc' => :build
  depends_on 'libdrm' => :library
  depends_on 'libomxil_bellagio' => :build
  depends_on 'libunwind' => :library
  depends_on 'libva' => :build
  depends_on 'libvdpau' => :build
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdamage' => :build
  depends_on 'libxdmcp' => :build
  depends_on 'libxext' => :library
  depends_on 'libxrandr' => :library
  depends_on 'libxshmfence' => :library
  depends_on 'libxv' => :build
  depends_on 'libxxf86vm' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'lm_sensors' => :library
  depends_on 'py3_mako' => :build
  depends_on 'py3_ply' => :build
  depends_on 'py3_pycparser' => :build
  depends_on 'spirv_llvm_translator' => :build
  depends_on 'spirv_tools' => :library
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols' => :build
  depends_on 'xcb_util_keysyms' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  conflicts_with 'libminigbm'
  no_lto # As per https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39671

  meson_options "-Db_asneeded=false \
    -Degl=enabled \
    -Dgbm=enabled \
    -Dgles1=disabled \
    -Dgles2=enabled \
    -Dglvnd=enabled \
    -Dglx=dri \
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

    if version.gsub("-#{CREW_LLVM_VER}", '').include?('26.1') && ARCH.include?('armv7l')
      patch = [
        [
          # See https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15553
          'https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40161.diff',
          '48c53f970da3efb91b573f8e8b03b71c2c3adfb2f73140c10aec72e52477dbb8'
        ]
      ]
      ConvenienceFunctions.patch(patch)
    end
  end
end
