# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  @_ver = '16.0.1'
  version @_ver
  # When upgrading llvm, be sure to upgrade openmp in tandem.
  # puts "#{self} version differs from llvm version #{Llvm.version}".orange if @_ver != Llvm.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag "llvmorg-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.1_armv7l/openmp-16.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.1_armv7l/openmp-16.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.1_i686/openmp-16.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.1_x86_64/openmp-16.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '30bde725ad52cb93d755b7e67ec5dbf87938a024faa9b10c2cdb12438867b682',
     armv7l: '30bde725ad52cb93d755b7e67ec5dbf87938a024faa9b10c2cdb12438867b682',
       i686: 'da60caaecaa4a2be9ea4221d017a90c807d573c0e103ca800fb7ac36b08459ac',
     x86_64: '7c9aa0feec687492923c75e72cf371f8bdfe45bcda8d20c4e254b6b83985394f'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libffi'
  depends_on 'llvm' # R
  depends_on 'python3' # R

  no_env_options

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
            -DLLVM_INCLUDE_BENCHMARKS=OFF \
            -DOPENMP_LIBDIR_SUFFIX=#{CREW_LIB_SUFFIX} \
            -DPYTHON_EXECUTABLE=$(which python3) \
            -Wno-dev \
            .."
      system 'mold -run ninja'
    end
  end

  def self.install
    Dir.chdir('openmp/builddir') do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
  end
end
