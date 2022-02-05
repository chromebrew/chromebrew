require 'package'

class Musl_native_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version 'd1395c'
  license 'MIT, LGPL-2 and GPL-2'
  compatibility 'all'
  source_url 'https://git.zv.io/toolchains/musl-cross-make.git'
  git_hashtag '53280e53a32202a0ee874911fc52005874db344b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/d1395c_armv7l/musl_native_toolchain-d1395c-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/d1395c_armv7l/musl_native_toolchain-d1395c-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/d1395c_i686/musl_native_toolchain-d1395c-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/d1395c_x86_64/musl_native_toolchain-d1395c-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '67f4c90e9604f2f9faa1862389a72a7d4ed9a7d202ea52eeb6a4aaab1d0a1d07',
     armv7l: '67f4c90e9604f2f9faa1862389a72a7d4ed9a7d202ea52eeb6a4aaab1d0a1d07',
       i686: '77bb046c80ac1b48df0d38a6a55f603a1c6f83805f2b7c23b59303199618c9bc',
     x86_64: 'a390c454918f3a3f4ada528f2f1f19e71ea276a293191b5ae9ecad2cb9b37bff'
  })

  @archflags = ''
  @linux_ver = '4.14.261'
  @target_tuple = "#{ARCH}-linux-musl"
  @gcc_version = '11-20220108'
  case ARCH
  when 'aarch64', 'armv7l'
    @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-fpu=neon --with-tune=cortex-a15'
    @target_tuple = 'armv7l-linux-musleabihf'
  when 'i686'
    @linux_ver = '3.8.12'
  end

  def self.patch
    load "#{CREW_LIB_PATH}lib/musl.rb"
    @config_mak = <<~CONFIG_MAK_EOF
      STAT = -static --static
      FLAG = -g0 -O2 -pipe -fno-align-functions -fno-align-jumps -fno-align-loops -fno-align-labels -Wno-error -fPIC

      ifneq (\$(NATIVE),)
      COMMON_CONFIG += CC="\$(HOST)-gcc \${STAT}" CXX="\$(HOST)-g++ \${STAT}" FC="\$(HOST)-gfortran \${STAT}"
      else
      COMMON_CONFIG += CC="gcc \${STAT}" CXX="g++ \${STAT}" FC="gfortran \${STAT}"
      endif

      COMMON_CONFIG += CFLAGS="\${FLAG}" CXXFLAGS="\${FLAG}" FFLAGS="\${FLAG}" LDFLAGS="-s \${STAT}"

      BINUTILS_CONFIG += --enable-gold --enable-plugins --enable-64-bit-bfd
      GCC_CONFIG += --enable-default-pie --enable-static-pie --disable-cet --without-zstd #{@archflags}

      CONFIG_SUB_REV = 888c8e3d5f7b
      GCC_VER = #{@gcc_version}
      BINUTILS_VER = 2.37
      MUSL_VER = git-d1395c43c019aec6b855cf3c656bf47c8a719e7f
      GMP_VER = 6.2.1
      ISL_VER = 0.23
      MPC_VER = 1.2.1
      MPFR_VER = 4.1.0
      LINUX_VER = #{@linux_ver}

      TARGET = #{@target_tuple}

      OUTPUT = #{CREW_DEST_MUSL_PREFIX}
    CONFIG_MAK_EOF
    File.write('config.mak', @config_mak)
    File.write('hashes/linux-3.8.12.tar.xz.sha1',
               '13d4f4f8f447b721e4a18ca39ed60fb7055d1de1 linux-3.8.12.tar.xz')
    File.write('hashes/linux-4.14.261.tar.xz.sha1',
               '28247a5448ac33e4031afa2544f384a525547b20 linux-4.14.261.tar.xz')
    File.write("hashes/gcc-#{@gcc_version}.tar.xz.sha1",
               "f89942362a87cb9c49f53177e7fcc57c77238197 gcc-#{@gcc_version}.tar.xz")
    FileUtils.mv 'patches/gcc-11-20211120', "patches/gcc-#{@gcc_version}"
  end

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system 'make'
  end

  def self.install
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "OUTPUT=#{CREW_DEST_MUSL_PREFIX} make install"
    # Delete libc symlink made to syslibdir
    FileUtils.rm_f "#{CREW_DEST_MUSL_PREFIX}/usr/local"
    # copy everything to standard locations
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}") do
      system 'cp -r * ../'
    end
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/lib") do
      # Delete broken symlink pointing to /lib/libc.so
      FileUtils.rm_f "#{CREW_DEST_MUSL_PREFIX}/lib/ld-musl-#{MUSL_ARCH}.so.1"
      FileUtils.ln "#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}/lib/libc.so",
                   "#{CREW_DEST_MUSL_PREFIX}/lib/ld-musl-#{MUSL_ARCH}.so.1", force: true
      FileUtils.ln "#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}/lib/libc.so", "#{CREW_DEST_MUSL_PREFIX}/lib/libc.so",
                   force: true
    end
    Dir.chdir(CREW_DEST_MUSL_PREFIX) do
      FileUtils.ln_sf 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end

  def self.postinstall
    return unless ARCH == 'i686'

    # perl needs this.
    FileUtils.ln_sf "#{CREW_MUSL_PREFIX}/#{@target_tuple}/include/locale.h",
                    "#{CREW_MUSL_PREFIX}/#{@target_tuple}/include/xlocale.h"
  end
end
