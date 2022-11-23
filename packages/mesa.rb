require 'package'

# We use mesa amber (derived from the 21.3 series) for intel hardware with older kernels
# and current mesa versions for newer kernels.
if !CREW_IN_CONTAINER && CREW_IS_INTEL && ( Gem::Version.new(CREW_KERNEL_VERSION) < Gem::Version.new('4.16') )
  Package.load_package( File.join(CREW_PACKAGES_PATH, 'mesa_amber.rb') )
  class Mesa < Package::Mesa_amber
    def self.preflight
      warn 'Installing mesa_amber as kernel is older than 4.16'.lightcyan
    end
  end
else
  class Mesa < Package
    description 'Open-source implementation of the OpenGL specification'
    homepage 'https://www.mesa3d.org'
    license 'MIT'
    @_ver = '22.3.0-rc3'
    version "#{@_ver}-1"
    compatibility 'aarch64,armv7l,x86_64'

    source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
    git_hashtag "mesa-#{@_ver}"

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
      vulkan_drivers = %w[swrast virtio-experimental]
      galliumdrivers = %w[swrast zink virgl]
      osmesa = true

      case ARCH
      when 'aarch64', 'armv7l'
        vulkan_drivers += %w[broadcom freedreno imagination-experimental panfrost]
        galliumdrivers += %w[freedreno nouveau tegra panfrost lima v3d vc4]
      when 'x86_64'
        vulkan_drivers += %w[amd intel intel_hasvk]
        galliumdrivers += %w[radeonsi iris crocus]
      end

      system <<~BUILD
        mold -run meson setup #{CREW_MESON_OPTIONS} \
          -Db_asneeded=false \
          -Ddri3=enabled \
          -Degl=enabled \
          -Dgbm=enabled \
          -Dgles2=enabled \
          -Dglvnd=true \
          -Dglx=dri \
          -Dllvm=enabled \
          -Dosmesa=#{osmesa} \
          -Dvulkan-drivers=#{vulkan_drivers.join(',')} \
          -Dgallium-drivers=#{galliumdrivers.join(',')} \
          -Dvideo-codecs='vc1dec,h264dec,h264enc,h265dec,h265enc' \
          builddir
      BUILD

      system 'meson configure builddir'
      system 'mold -run samu -C builddir'
    end

    def self.install
      FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/etc/mesa_driver_supported_list/ #{CREW_DEST_LIB_PREFIX}/gbm/tls]

      # copy supported pci list to filesystem for sommelier use
      FileUtils.cp_r Dir['include/pci_ids/*_pci_ids.h'], "#{CREW_DEST_PREFIX}/etc/mesa_driver_supported_list/"

      system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"

      # The following are hacks to keep sommelier from complaining.
      Dir.chdir("#{CREW_DEST_LIB_PREFIX}/dri") do
        FileUtils.ln_s '.', 'tls' unless File.exist?('tls')
      end

      case ARCH
      when 'x86_64'
        Dir.chdir("#{CREW_DEST_LIB_PREFIX}/gbm/tls") do
          # For Intel GPUs
          FileUtils.ln_s '../../libgbm.so', 'i915_gbm.so'
          # For AMD GPUs
          FileUtils.ln_s '../../libgbm.so', 'amdgpu_gbm.so'
          # For QEMU virgl
          FileUtils.ln_s '../../libgbm.so', 'virtio_gpu_gbm.so'
        end
      when 'armv7l', 'aarch64'
        Dir.chdir("#{CREW_DEST_LIB_PREFIX}/gbm/tls") do
          FileUtils.ln_s '../../libgbm.so', 'pvr_gbm.so'
        end
      end
    end
  end
end