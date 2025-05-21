require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Libssp < Package
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  @gcc_libc_version = '2.41'
  version '15.1.0' # Do not use @_ver here, it will break the installer.
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'https://github.com/gcc-mirror/gcc.git'
  git_hashtag '911cfea5e59798e04479ad475870935ccfae004b'
  # git_hashtag "releases/gcc-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da5249be0eea8cf62b0f55a02c1da9607da20a26141d5ea7109458a6b2b54404',
     armv7l: 'da5249be0eea8cf62b0f55a02c1da9607da20a26141d5ea7109458a6b2b54404',
       i686: '2e12ff67c304c07b098114c6e2b9a9fe3bf7ea2e40ba8371afe0e0ac83318ce5',
     x86_64: 'cef01eff2b6636e75e4f179ee2309bbab135cb401d66682c0b6eabce4b81e096'
  })

  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R

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

  def self.patch
    # make sure we are using our shell instead of /bin/sh
    system "grep -rlZ '/bin/sh ' . | xargs -0 sed -i 's,/bin/sh ,#{CREW_PREFIX}/bin/sh ,g'"
    system "grep -rlZ \"/bin/sh\\\"\" . | xargs -0 sed -i 's,/bin/sh\",#{CREW_PREFIX}/bin/sh\",g'"
    system "grep -rlZ \"/bin/sh'\" . | xargs -0 sed -i \"s,/bin/sh',#{CREW_PREFIX}/bin/sh',g\""
  end

  def self.build
    gcc_version = version.split('-')[0]

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
