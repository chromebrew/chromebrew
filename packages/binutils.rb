# Adapted in part from Arch Linux binutils PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/binutils/-/blob/main/PKGBUILD
require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '2.43-gcc14'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{version.split('-').first}.tar.bz2"
  source_sha256 'fed3c3077f0df7a4a1aa47b080b8c53277593ccbb4e5e78b73ffb4e3f265e750'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2495535e6fb7b8d8ed7eadd4072192cd14526f0edb111b57968aa6fc43b93a00',
     armv7l: '2495535e6fb7b8d8ed7eadd4072192cd14526f0edb111b57968aa6fc43b93a00',
       i686: 'd31cfcbf745167c12d286284bc46d72c56a4e43c22fa0d27c39458ec0355c88e',
     x86_64: '2c7087344bd4eee7df8402b6a69f4e2d043163298eb37ff68b1a74dc7324dbae'
  })

  depends_on 'elfutils' # R
  depends_on 'flex' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  def self.prebuild
    FileUtils.rm_f "#{CREW_LIB_PREFIX}/libiberty.a"
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
      system "../configure #{CREW_OPTIONS} \
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
        #{ARCH == 'i686' || ARCH == 'x86_64' ? '--disable-gprofng' : ''} \
        --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
        --with-lib-path=#{CREW_LIB_PREFIX} \
        --with-pic \
        --with-pkgversion=Chromebrew \
        --with-system-zlib"
      system 'make configure-host'
      system "make tooldir=#{CREW_PREFIX} || make -j 1"
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
