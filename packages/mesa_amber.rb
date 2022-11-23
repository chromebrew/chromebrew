require 'package'

class Mesa_amber < Package
  description 'Open-source implementation of the OpenGL specification (Legacy i965 driver)'
  homepage 'https://www.mesa3d.org'
  @_commit = 'acfef002a081f36e6eebc6e8ab908a36ab18f68c'
  @_ver = "21.3.9-#{@_commit[0, 7]}"
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'x86_64'

  source_url 'https://gitlab.freedesktop.org/mesa/mesa.git'
  git_hashtag @_commit

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

  def self.preflight
    abort 'Please remove "mesa" before installing "mesa_amber".'.yellow if File.exist?("#{CREW_META_PATH}/mesa.filelist")
  end

  def self.patch
    puts 'Downloading patches...'.yellow
    system 'curl', '-LZO', 'https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/{13273,15381,15091,15232,16129,16289,17514}.diff'

    # another llvm 15 patch
    # Refreshed patch from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/17518.diff
    File.write '17518.patch', <<~'PATCH_EOF'
      diff -Npaur a/lp_bld_arit.c b/lp_bld_arit.c
      --- a/src/gallium/auxiliary/gallivm/lp_bld_arit.c
      +++ b/src/gallium/auxiliary/gallivm/lp_bld_arit.c
      @@ -391,16 +391,10 @@ lp_build_comp(struct lp_build_context *b
                return LLVMBuildNot(builder, a, "");
          }

      -   if(LLVMIsConstant(a))
      -      if (type.floating)
      -          return LLVMConstFSub(bld->one, a);
      -      else
      -          return LLVMConstSub(bld->one, a);
      +   if (type.floating)
      +      return LLVMBuildFSub(builder, bld->one, a, "");
          else
      -      if (type.floating)
      -         return LLVMBuildFSub(builder, bld->one, a, "");
      -      else
      -         return LLVMBuildSub(builder, bld->one, a, "");
      +      return LLVMBuildSub(builder, bld->one, a, "");
       }


      @@ -479,16 +473,10 @@ lp_build_add(struct lp_build_context *bl
             }
          }

      -   if(LLVMIsConstant(a) && LLVMIsConstant(b))
      -      if (type.floating)
      -         res = LLVMConstFAdd(a, b);
      -      else
      -         res = LLVMConstAdd(a, b);
      +   if (type.floating)
      +      res = LLVMBuildFAdd(builder, a, b, "");
          else
      -      if (type.floating)
      -         res = LLVMBuildFAdd(builder, a, b, "");
      -      else
      -         res = LLVMBuildAdd(builder, a, b, "");
      +      res = LLVMBuildAdd(builder, a, b, "");

          /* clamp to ceiling of 1.0 */
          if(bld->type.norm && (bld->type.floating || bld->type.fixed))
      @@ -815,16 +803,10 @@ lp_build_sub(struct lp_build_context *bl
             }
          }

      -   if(LLVMIsConstant(a) && LLVMIsConstant(b))
      -      if (type.floating)
      -         res = LLVMConstFSub(a, b);
      -      else
      -         res = LLVMConstSub(a, b);
      +   if (type.floating)
      +      res = LLVMBuildFSub(builder, a, b, "");
          else
      -      if (type.floating)
      -         res = LLVMBuildFSub(builder, a, b, "");
      -      else
      -         res = LLVMBuildSub(builder, a, b, "");
      +      res = LLVMBuildSub(builder, a, b, "");

          if(bld->type.norm && (bld->type.floating || bld->type.fixed))
             res = lp_build_max_simple(bld, res, bld->zero, GALLIVM_NAN_RETURN_OTHER_SECOND_NONNAN);
      @@ -980,29 +962,15 @@ lp_build_mul(struct lp_build_context *bl
          else
             shift = NULL;

      -   if(LLVMIsConstant(a) && LLVMIsConstant(b)) {
      -      if (type.floating)
      -         res = LLVMConstFMul(a, b);
      -      else
      -         res = LLVMConstMul(a, b);
      -      if(shift) {
      -         if(type.sign)
      -            res = LLVMConstAShr(res, shift);
      -         else
      -            res = LLVMConstLShr(res, shift);
      -      }
      -   }
      -   else {
      -      if (type.floating)
      -         res = LLVMBuildFMul(builder, a, b, "");
      +   if (type.floating)
      +       res = LLVMBuildFMul(builder, a, b, "");
      +    else
      +       res = LLVMBuildMul(builder, a, b, "");
      +    if (shift) {
      +       if (type.sign)
      +          res = LLVMBuildAShr(builder, res, shift, "");
             else
      -         res = LLVMBuildMul(builder, a, b, "");
      -      if(shift) {
      -         if(type.sign)
      -            res = LLVMBuildAShr(builder, res, shift, "");
      -         else
      -            res = LLVMBuildLShr(builder, res, shift, "");
      -      }
      +          res = LLVMBuildLShr(builder, res, shift, "");
          }

          return res;
      @@ -1288,15 +1256,6 @@ lp_build_div(struct lp_build_context *bl
          if(a == bld->undef || b == bld->undef)
             return bld->undef;

      -   if(LLVMIsConstant(a) && LLVMIsConstant(b)) {
      -      if (type.floating)
      -         return LLVMConstFDiv(a, b);
      -      else if (type.sign)
      -         return LLVMConstSDiv(a, b);
      -      else
      -         return LLVMConstUDiv(a, b);
      -   }
      -
          /* fast rcp is disabled (just uses div), so makes no sense to try that */
          if(FALSE &&
             ((util_get_cpu_caps()->has_sse && type.width == 32 && type.length == 4) ||
      @@ -2643,7 +2602,7 @@ lp_build_rcp(struct lp_build_context *bl
          assert(type.floating);

          if(LLVMIsConstant(a))
      -      return LLVMConstFDiv(bld->one, a);
      +      return LLVMBuildFDiv(builder, bld->one, a, "");

          /*
           * We don't use RCPPS because:

    PATCH_EOF

    # llvm 13/14 patch  See https://gitlab.freedesktop.org/mesa/mesa/-/issues/5455
    # & https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/13273.patch
    system 'patch', '-Np1', '-i', '13273.diff'
    # mesa: Implement ANGLE_sync_control_rate (used by Chrome browser)
    system 'patch', '-Np1', '-i', '15381.diff'
    # llvm 15 patch
    system 'patch', '-Np1', '-i', '15091.diff'
    system 'patch', '-Np1', '-i', '15232.diff'
    system 'patch', '-Np1', '-i', '16129.diff'
    system 'patch', '-Np1', '-F', '10', '-i', '16289.diff'
    system 'patch', '-Np1', '-i', '17514.diff'
    system 'patch', '-Np1', '-i', '17518.patch'
  end

  def self.build
    system <<~BUILD
      mold -run meson setup #{CREW_MESON_OPTIONS} \
        -Db_asneeded=false \
        -Damber=true \
        -Ddri3=enabled \
        -Degl=enabled \
        -Dgbm=enabled \
        -Dgles2=enabled \
        -Dglvnd=true \
        -Dglx=dri \
        -Dllvm=enabled \
        -Dshared-glapi=enabled \
        -Dvulkan-drivers=intel \
        -Ddri-drivers=i965 \
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

    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/gbm/tls") do
      # For Intel GPUs
      FileUtils.ln_s '../../libgbm.so', 'i915_gbm.so'
    end
  end

  # mark mesa as "installed"
  # TODO: Add `provide` function to crew for marking
  #       package as a fake package provided by another package
  def self.postinstall
    Dir.chdir(CREW_META_PATH) do
      FileUtils.cp 'mesa.filelist', 'mesa_amber.filelist'
      FileUtils.cp 'mesa.directory', 'mesa_amber.directorylist'
    end

    device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
    device[:installed_packages] << { name:, version: }
    File.write( "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(device) )
  end

  # remove the "installed" mesa also
  def self.remove
    Dir.chdir(CREW_META_PATH) do
      FileUtils.rm_f Dir['mesa.{filelist,directorylist}']
    end

    device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
    device[:installed_packages].reject! {|pkg| pkg[:name] == 'mesa' }
    File.write( "#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(device) )
  end
end
