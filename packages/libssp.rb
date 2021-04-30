require 'package'

class Libssp < Package
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  version '11.1.0'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-11.1.0/gcc-11.1.0.tar.xz'
  source_sha256 '4c4a6fb8a8396059241c2e674b85b351c26a5d678274007f076957afa1cc9ddf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_armv7l/libssp-11.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_armv7l/libssp-11.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_i686/libssp-11.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_x86_64/libssp-11.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '21d6872debb576b442a0a62ab7d0ae4bc765db83bf43cdb8e11c28f56e51d456',
     armv7l: '21d6872debb576b442a0a62ab7d0ae4bc765db83bf43cdb8e11c28f56e51d456',
       i686: '5b02bf769ec3754f4b0c937e5420f13bf285bc81bdc9c68fbc6f63c56562682b',
     x86_64: '356cd568080dd0e724081ec7f020d0b21e091d5552d175746f830c48830bd8b9'
  })

  depends_on 'ccache' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R

  @gcc_name = 'libssp'

  @gcc_global_opts = '--disable-libmpx \
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
    @archflags = '--with-arch=armv7-a --with-float=hard --with-fpu=neon --with-tune=cortex-a15'
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
