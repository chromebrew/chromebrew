# Adapted in part from Arch Linux binutils PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/binutils/-/blob/main/PKGBUILD
require 'English'
require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version "2.46.1-#{CREW_GCC_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://sourceware.org/git/binutils-gdb.git'
  git_hashtag "binutils-#{version.gsub("-#{CREW_GCC_VER}", '').gsub('.', '_')}"
  # source_url "https://sourceware.org/pub/binutils/releases/binutils-#{version.split('-').first}.tar.zst"
  # source_sha256 '79cb120b39a195ad588cd354aed886249bfab36c808e746b30208d15271cc95c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76daf7ca27a890e608a7d964d920fa6603b4e1d872edfb8d2e8900eb4d820e18',
     armv7l: '76daf7ca27a890e608a7d964d920fa6603b4e1d872edfb8d2e8900eb4d820e18',
       i686: 'c9d0beb18cbf26aad7d1f30602d6a4f4c6a0a72c74453f7de1aad00f9be67be7',
     x86_64: 'a38024e661ffeaa2cbe87cb1c5b199efd4efd0cd51a26391d2323af886dbabd5'
  })

  depends_on 'elfutils' => :build
  depends_on 'flex' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  def self.prebuild
    FileUtils.rm_f "#{CREW_LIB_PREFIX}/libiberty.a"
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
  end

  def self.patch
    system 'filefix'
    system "sed -i 's,scriptdir = $(tooldir)/lib,scriptdir = $(tooldir)/#{ARCH_LIB},g' ld/Makefile.am"
    Dir.chdir 'ld' do
      system 'aclocal && automake'
    end
    system "sed -i '/^development=/s/true/false/' bfd/development.sh"
  end

  def self.build
    # gprofng is broken on i686 in binutils 2.40
    # https://sourceware.org/bugzilla/show_bug.cgi?id=30006
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "../configure #{CREW_CONFIGURE_OPTIONS} \
        --disable-bootstrap \
        --disable-gdb \
        --disable-gdbserver \
        --disable-maintainer-mode \
        --enable-64-bit-bfd \
        --enable-colored-disassembly \
        --enable-gold \
        --enable-install-libiberty \
        --enable-ld \
        --enable-ld=default \
        --enable-lto \
        --enable-plugins \
        --enable-relro \
        --enable-shared \
        --enable-threads \
        --enable-vtable-verify \
        #{'--disable-gprofng' if ARCH == 'i686' || ARCH == 'x86_64'} \
        --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
        --with-lib-path=#{CREW_LIB_PREFIX} \
        --with-pic \
        --with-pkgversion=Chromebrew \
        --with-system-zlib"
      system 'make configure-host'
      system "make prefix=#{CREW_PREFIX} tooldir=#{CREW_PREFIX}"
      system 'make -j1' if $CHILD_STATUS.exitstatus != 0
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make -O CFLAGS_FOR_TARGET="-O2 -g" \
        CXXFLAGS="-O2 -no-pie -fno-PIC" \
        CFLAGS="-O2 -no-pie" \
        LDFLAGS="" \
        check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}",
             "tooldir=#{CREW_PREFIX}", 'install'
      # install PIC version of libiberty
      FileUtils.install 'libiberty/pic/libiberty.a', "#{CREW_DEST_LIB_PREFIX}/", mode: 0o644

      # No shared linking to these files outside binutils
      FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libbfd.so"
      FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libopcodes.so"
      File.write "#{CREW_DEST_LIB_PREFIX}/libbfd.so", <<~LIB_BFD_EOF
        /* GNU ld script */

        INPUT( #{CREW_LIB_PREFIX}/libbfd.a -lsframe -liberty -lz -lzstd -ldl )
      LIB_BFD_EOF

      File.write "#{CREW_DEST_LIB_PREFIX}/libopcodes.so", <<~LIB_OPCODES_EOF
        /* GNU ld script */

        INPUT( #{CREW_LIB_PREFIX}/libopcodes.a -lbfd )
      LIB_OPCODES_EOF
      # Needed for gdb.
      @oldlibs = %w[bfd opcodes]
      @oldlibs.each do |oldlib|
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/lib#{oldlib}-#{@_ver}.so",
                        "#{CREW_DEST_LIB_PREFIX}/lib#{oldlib}-2.39.50.so"
      end
    end
  end
end
