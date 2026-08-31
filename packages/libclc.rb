require 'package'

class Libclc < Package
  llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
  description 'Library requirements of the OpenCL C programming language'
  homepage 'https://libclc.llvm.org/'
  version llvm_build_obj.version
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{llvm_build_obj.version}".orange if version != llvm_build_obj.version && !ENV['NESTED_CI']
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url llvm_build_obj.source_url
  source_sha256 llvm_build_obj.source_sha256
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '934ceaabcaa829e6b25694087801ad8218d2426fb578385ef358153a9a239a5a',
     armv7l: '934ceaabcaa829e6b25694087801ad8218d2426fb578385ef358153a9a239a5a',
     x86_64: '26d0ad0b82019b5ec0258fcadd227a89fde1f86f63f5a601dc19a9e16fd8a6fe'
  })

  depends_on 'llvm_dev' => :build
  depends_on 'python3' => :build
  depends_on 'spirv_llvm_translator' => :build

  no_env_options

  @libclc_runtime_targets = %w[
    amdgcn-amd-amdhsa-llvm
    nvptx64-nvidia-cuda
    spirv32-unknown-unknown
    spirv64-unknown-unknown
    spirv32-unknown-vulkan
    spirv64-unknown-vulkan
  ]

  def self.preflight
    llvm_dev_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_dev.rb")
    abort "Update  #{CREW_LLVM_VER}_dev first.".lightred if Gem::Version.new(version.split('-').first) > Gem::Version.new(llvm_dev_obj.version.split('-').first)
  end

  def self.patch
    # Remove rc suffix on final release.
    system "sed -i 's,set(LLVM_VERSION_SUFFIX rc),,' llvm/CMakeLists.txt"

    patches = [
      # Fix for pkconfig file deprecation.
      ['https://aur.archlinux.org/cgit/aur.git/plain/revert-10644a1-v3.patch?h=libclc-minimal-git', '4f215e748c4c1a59f621ae58d2685651c442e3e79fa77c4c0153bd201f02a4de']
    ]
    ConvenienceFunctions.patch(patches)
  end

  def self.build
    # See https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/23/debian/rules?ref_type=heads
    # and https://github.com/Homebrew/homebrew-core/blob/149a149bb7fc18bee0663f3fa00b74cbc46d1a64/Formula/lib/libclc.rb
    # and https://aur.archlinux.org/cgit/aur.git/plain/revert-10644a1-v3.patch?h=libclc-minimal-git
    @libclc_runtime_targets.each do |target|
      puts "Building libclc target #{target}".orange
      builddir = "builddir-#{target}"
      system "cmake -S libclc -B #{builddir} -G Ninja \
        -DLLVM_DEFAULT_TARGET_TRIPLE=#{target} \
        -DCMAKE_CLC_COMPILER=#{`which clang`.chomp} \
        -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} \
        -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
        -DCMAKE_LIBRARY_PATH='#{CREW_GLIBC_INTERPRETER.nil? ? CREW_LIB_PREFIX : "#{CREW_GLIBC_PREFIX};#{CREW_LIB_PREFIX}"}' \
        -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
        -Wno-author"
      system "#{CREW_NINJA} -C #{builddir}"
    end
  end

  def self.install
    @libclc_runtime_targets.each do |target|
      puts "Installing libclc target #{target}".orange
      builddir = "builddir-#{target}"
      system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C #{builddir} install"
    end
    FileUtils.ln_s "#{CREW_PREFIX}/share/clc/spirv32-unknown-unknown/libclc.spv", "#{CREW_DEST_PREFIX}/share/clc/spirv-mesa3d-.spv"
    FileUtils.ln_s "#{CREW_PREFIX}/share/clc/spirv64-unknown-unknown/libclc.spv", "#{CREW_DEST_PREFIX}/share/clc/spirv64-mesa3d-.spv"
  end
end
