# Adapted in part from Arch Linux binutils PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/binutils/-/blob/main/PKGBUILD
require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version "2.43.1-1-#{CREW_GCC_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{version.split('-').first}.tar.bz2"
  source_sha256 'becaac5d295e037587b63a42fad57fe3d9d7b83f478eb24b67f9eec5d0f1872f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87ef59c724f898b971acd812d7ccdb4358d57d55241af11224ecb232e1e70246',
     armv7l: '87ef59c724f898b971acd812d7ccdb4358d57d55241af11224ecb232e1e70246',
       i686: '383dde3bfe1eade13cf44a766007f0de88dda09bae9d216dcd5817be710f5d13',
     x86_64: '87b38a48b7987f12b92eda6ab9292d6e93a8fc7fbbde990bcbdf1cbc1348af23'
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
