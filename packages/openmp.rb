# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  @_ver = '16.0.0-rc1'
  version @_ver
  # When upgrading llvm, be sure to upgrade openmp in tandem.
  # puts "#{self} version differs from llvm version #{Llvm.version}".orange if @_ver != Llvm.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag "llvmorg-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc1_armv7l/openmp-16.0.0-rc1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc1_armv7l/openmp-16.0.0-rc1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc1_i686/openmp-16.0.0-rc1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc1_x86_64/openmp-16.0.0-rc1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a8b5a1770a714283db2005d5519014756ed31601cefb80f060a21f210f2ae5a8',
     armv7l: 'a8b5a1770a714283db2005d5519014756ed31601cefb80f060a21f210f2ae5a8',
       i686: '742a5671d9a8a6b38073e9f6c56eec0778f0f8128d4e8abe6cfc0d67d66aa9f4',
     x86_64: 'f9c667a78a71552e852a34cabeee05557c9427b0860b8d355c94eba4fccfc130'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libffi'
  depends_on 'llvm' # R
  depends_on 'python3' # R

  no_env_options

  def self.patch
    # See https://github.com/llvm/llvm-project/issues/60393
    # This should be gone by llvm 16 final.
    downloader 'https://reviews.llvm.org/file/data/g3g6o5c5blv6cpw4vsi5/PHID-FILE-osrdddmkv4akws36db7u/D143200.diff',
               'SKIP'
    system 'patch -Np1 -i D143200.diff'
  end

  def self.build
    Dir.mkdir 'openmp/builddir'
    Dir.chdir 'openmp/builddir' do
      system "cmake -G Ninja \
            #{CREW_CMAKE_FNO_LTO_OPTIONS.gsub('-fno-lto', '').gsub('-ffat-lto-objects', '')} \
            -DCMAKE_C_COMPILER=$(which clang) \
            -DCMAKE_C_COMPILER_TARGET=#{CREW_BUILD} \
            -DCMAKE_CXX_COMPILER=$(which clang++) \
            -DCMAKE_CXX_COMPILER_AR=$(which llvm-ar) \
            -DCMAKE_CXX_COMPILER_RANLIB=$(which llvm-ranlib) \
            -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
            -DLIBOMP_ENABLE_SHARED=ON \
            -DLIBOMP_INSTALL_ALIASES=OFF \
            -DOPENMP_LIBDIR_SUFFIX=#{CREW_LIB_SUFFIX} \
            -DPYTHON_EXECUTABLE=$(which python3) \
            -DLLVM_INCLUDE_BENCHMARKS=OFF \
            -Wno-dev \
            .."
      system 'ninja'
    end
  end

  def self.install
    Dir.chdir('openmp/builddir') do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
  end
end
