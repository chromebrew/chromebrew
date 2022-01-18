require 'package'

class Libssp < Package
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  version '11.2.1-20220108'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://gcc.gnu.org/pub/gcc/snapshots/11-20220108/gcc-11-20220108.tar.xz'
  source_sha256 'a433837a85087c2357a456145ae140bd588e75d44a90031ed57c29de66e46468'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.2.1-20220108_i686/libssp-11.2.1-20220108-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.2.1-20220108_armv7l/libssp-11.2.1-20220108-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.2.1-20220108_armv7l/libssp-11.2.1-20220108-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.2.1-20220108_x86_64/libssp-11.2.1-20220108-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: 'a8459db3bf278ca9cd120d3d7b166def4816fc112a42869968a2801eb4ceca81',
    aarch64: 'b7bdc82eca1ade26a484837a9b544852b9c3e5e5f4cbe571213e35e9c417398d',
     armv7l: 'b7bdc82eca1ade26a484837a9b544852b9c3e5e5f4cbe571213e35e9c417398d',
     x86_64: 'b443fabf868ac235e2b7e621c9eeec34389e469a87f180a9aaccaa01256b8038'
  })

  depends_on 'ccache' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R

  @gcc_name = 'libssp'

  @gcc_global_opts = '--disable-libmpx \
  --disable-install-libiberty \
  --disable-libssp \
  --disable-multilib \
  --disable-werror \
  --enable-cet=auto \
  --enable-checking=release \
  --enable-clocale=gnu \
  --enable-default-pie \
  --enable-default-ssp \
  --enable-gnu-indirect-function \
  --enable-gnu-unique-object \
  --enable-host-shared \
  --enable-lto \
  --enable-plugin \
  --enable-shared \
  --enable-symvers \
  --enable-static \
  --enable-threads=posix \
  --with-gcc-major-version-only \
  --with-gmp \
  --with-isl \
  --with-mpc \
  --with-mpfr \
  --with-pic \
  --with-system-libunwind \
  --with-system-zlib'

  @cflags = '-fPIC -pipe'
  @cxxflags = '-fPIC -pipe'
  @languages = 'c,c++,jit,objc,fortran,go'
  case ARCH
  when 'armv7l', 'aarch64'
    @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-fpu=neon --with-tune=cortex-a15'
  when 'x86_64'
    @archflags = '--with-arch-64=x86-64'
  when 'i686'
    @archflags = '--with-arch-32=i686'
  end

  def self.build
    # Set ccache sloppiness as per
    # https://wiki.archlinux.org/index.php/Ccache#Sloppiness
    system 'ccache --set-config=sloppiness=file_macro,locale,time_macros'
    # Prefix ccache to path.
    @path = "#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin"

    gcc_version = version.split('-')[0]

    Dir.mkdir "#{@gcc_name}-builddir"
    Dir.chdir "#{@gcc_name}-builddir" do
      system "env NM=gcc-nm AR=gcc-ar RANLIB=gcc-ranlib \
        CFLAGS='#{@cflags}' CXXFLAGS='#{@cxxflags}' \
        PATH=#{@path} \
        ../#{@gcc_name}/configure #{CREW_OPTIONS} \
        #{@gcc_global_opts} \
        --enable-languages=#{@languages} \
        --program-suffix=-#{gcc_version} \
        #{@archflags}"
      system "env PATH=#{@path} \
        make"
    end
  end

  def self.check
    Dir.chdir "#{@gcc_name}-builddir" do
      system 'make check'
    end
  end

  def self.install
    Dir.chdir "#{@gcc_name}-builddir" do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
