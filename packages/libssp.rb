require 'package'

class Libssp < Package
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  version '12.2.1-b80a690'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://github.com/gcc-mirror/gcc.git'
  git_hashtag 'b80a690673272919896ee5939250e50d882f2418'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/12.2.1-b80a690_armv7l/libssp-12.2.1-b80a690-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/12.2.1-b80a690_armv7l/libssp-12.2.1-b80a690-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/12.2.1-b80a690_i686/libssp-12.2.1-b80a690-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/12.2.1-b80a690_x86_64/libssp-12.2.1-b80a690-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3776481deeb8dde51144ddf76be645b6a5935d0fc8b8ed72a4371887eb54c78b',
     armv7l: '3776481deeb8dde51144ddf76be645b6a5935d0fc8b8ed72a4371887eb54c78b',
       i686: '1031c6b3d3b917c59674fcfb89d36e800d4e4671dfed387b930992cf0ad53484',
     x86_64: 'f9889ae9a6f85730a203793f891c7152cf6e548d0fd012929bd719230157ee97'
  })

  # depends_on 'ccache' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R

  patchelf

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
    @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-tune=cortex-a15 --with-fpu=vfpv3-d16'
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
