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
  compatibility 'all'
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag "llvmorg-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/15.0.2_armv7l/openmp-15.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/15.0.2_armv7l/openmp-15.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/15.0.2_i686/openmp-15.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/15.0.2_x86_64/openmp-15.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1959ad7a1990b976c00ff0017c934e83874de75693d544f72ba0b7b09113aef4',
     armv7l: '1959ad7a1990b976c00ff0017c934e83874de75693d544f72ba0b7b09113aef4',
       i686: 'df454f2ea8052853943241282265785f04f532b929114f2b0a4002027a08d3d0',
     x86_64: '685c4751bcf4f6c37aa040a7fe15be18228a3a4ba10ac646159edb87edcce4b4'
  })

  depends_on 'libffi'
  depends_on 'llvm' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  no_env_options

  def self.patch
    return unless ARCH == 'armv7l' || ARCH == 'aarch64'

    open('openmp/CMakeLists.txt', 'a') do |f|
      f.puts 'set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")'
      f.puts 'set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")'
    end
  end

  def self.build
    Dir.mkdir 'openmp/builddir'
    Dir.chdir 'openmp/builddir' do
      system "cmake -G Ninja \
            #{CREW_CMAKE_OPTIONS.gsub('-flto', '').gsub('mold', 'lld')} \
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
