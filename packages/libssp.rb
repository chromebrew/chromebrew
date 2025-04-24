require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Libssp < Package
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  @gcc_libc_version = if %w[2.23 2.27 2.32 2.33 2.35 2.37].any? { |i| LIBC_VERSION.include? i }
                        LIBC_VERSION
                      else
                        ARCH.eql?('i686') ? '2.23' : '2.27'
                      end
  version "15.1.0-RC-20250423-glibc#{@gcc_libc_version}" # Do not use @_ver here, it will break the installer.
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'https://gcc.gnu.org/pub/gcc/snapshots/15.1.0-RC-20250423/gcc-15.1.0-RC-20250423.tar.xz'
  source_sha256 '50585c01ba3b7ca6ed1bc49efe8de9bd83583a5a4f501d7238c4976ba3784b59'
  # source_url 'https://github.com/gcc-mirror/gcc.git'
  # git_hashtag "releases/gcc-#{version.split('-').first}"
  binary_compression 'tar.zst'

  case @gcc_libc_version
  when '2.23'

    binary_sha256({
       i686: '804bc68e33261da2ba1b2bdd5d984f0b368640afba6791cd4f045813b5a469f7'
  })
  when '2.27', '2.32', '2.33', '2.35'

    binary_sha256({
    aarch64: '2243ac269cd087cf4a5c6e9c86f9b652ea2d056eed0bcb9d23e104d64ed09967',
     armv7l: '2243ac269cd087cf4a5c6e9c86f9b652ea2d056eed0bcb9d23e104d64ed09967',
     x86_64: '1192c622117d3f3394f0da2e4e5912cfd464c87bb82fa2d0db4a3add6085b44b'
  })
  when '2.37'
    binary_sha256({
      aarch64: '80428580f3ff02c0b8aa0b65ec64626e906b59d754851f289210360686bdb8d1',
       armv7l: '80428580f3ff02c0b8aa0b65ec64626e906b59d754851f289210360686bdb8d1',
       x86_64: '69114b1e6bcd208d14305e39de47e32aa8781af96f2ad3cced8333fb2d602ec3'
    })
  end

  depends_on 'ccache' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R

  @gcc_name = 'libssp'

  @gcc_global_opts = "--build=#{CREW_TARGET} \
  --host=#{CREW_TARGET} \
  --target=#{CREW_TARGET} \
  --disable-libmpx \
  --disable-install-libiberty \
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
  --with-system-zlib"

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
        ../#{@gcc_name}/configure #{CREW_CONFIGURE_OPTIONS} \
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
