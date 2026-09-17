require 'package'

class Libssp < Package
  gcc_build_obj = Package.load_package("#{__dir__}/gcc16_build.rb")
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  version '16.2.1-7799a75'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, libssp, and then binutils in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{gcc_build_obj.version}".orange if version != gcc_build_obj.version
  compatibility 'all'
  source_url 'https://gcc.gnu.org/pub/gcc/snapshots/LATEST-16/gcc-16-20260912.tar.xz'
  source_sha256 '487fa9ed3b0c34a06ea6049dcbcb239f6a7807f2974083426b287f4c4f011db5'
  # Built from 7799a75054edd195627f794b4766f80566f5d368
  # source_url 'https://github.com/gcc-mirror/gcc.git'
  # git_hashtag "releases/gcc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2fe0da2d03a296c9ca4ab7944c9ec9daad5b91690ed087e02d99e0a89eb33de5',
     armv7l: '2fe0da2d03a296c9ca4ab7944c9ec9daad5b91690ed087e02d99e0a89eb33de5',
       i686: '1f31d6eff9a04a247987b7cf7ab05f1fb8c6d64f442d720d2e2bef319858cf66',
     x86_64: 'b4ce091a8ff1dc58b5b0a9434cec2e653b0fa15dee698f61b22b3bf3b8a422ee'
  })

  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

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
  @languages = 'c,c++,jit,objc,fortran,go,rust'
  case ARCH
  when 'armv7l', 'aarch64'
    @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-tune=cortex-a15 --with-fpu=vfpv3-d16'
  when 'x86_64'
    @archflags = '--with-arch-64=x86-64'
  when 'i686'
    @archflags = '--with-arch-32=i686'
  end

  def self.patch
    # make sure we are using our shell instead of /bin/sh
    system "grep -rlZ '/bin/sh ' . | xargs -0 sed -i 's,/bin/sh ,#{CREW_PREFIX}/bin/sh ,g'"
    system "grep -rlZ \"/bin/sh\\\"\" . | xargs -0 sed -i 's,/bin/sh\",#{CREW_PREFIX}/bin/sh\",g'"
    system "grep -rlZ \"/bin/sh'\" . | xargs -0 sed -i \"s,/bin/sh',#{CREW_PREFIX}/bin/sh',g\""
  end

  def self.build
    gcc_version = version.partition('.')[0]

    Dir.mkdir "#{@gcc_name}-builddir"
    Dir.chdir "#{@gcc_name}-builddir" do
      system "env NM=gcc-nm AR=gcc-ar RANLIB=gcc-ranlib \
        CFLAGS='#{@cflags}' CXXFLAGS='#{@cxxflags}' \
        ../#{@gcc_name}/configure #{CREW_CONFIGURE_OPTIONS} \
        #{@gcc_global_opts} \
        --enable-languages=#{@languages} \
        --program-suffix=-#{gcc_version} \
        #{@archflags}"
      system 'make'
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
