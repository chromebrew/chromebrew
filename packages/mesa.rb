require 'buildsystems/meson'

class Mesa < Meson
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version "26.0.5-#{CREW_LLVM_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
  git_hashtag "mesa-#{version.split('-')[0..-2].join('-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '670f02ee5a14601099deb2f0e5f577651ab7102f0f0bebda1b90ba098ed0dab3',
     armv7l: '670f02ee5a14601099deb2f0e5f577651ab7102f0f0bebda1b90ba098ed0dab3',
     x86_64: '6362ab7d19c7653d9fc074f2e14f6e7ec25df16586ab823a9d6c57f973ab3f9b'
  })

  depends_on 'elfutils' => :library
  depends_on 'eudev' => :library
  depends_on 'expat' => :library
  depends_on 'gcc_dev' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glslang' => :build
  depends_on 'libclc' => :build
  depends_on 'libdrm' => :library
  depends_on 'libminigbm' => :library
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

  no_lto # As per https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39671

  meson_options "#{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
    -Db_asneeded=false \
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
  end
end
