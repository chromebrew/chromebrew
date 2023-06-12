require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.40'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.bz2"
  source_sha256 'f8298eb153a4b37d112e945aa5cb2850040bcf26a3ea65b5a715c83afe05e48a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.40_armv7l/binutils-2.40-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.40_armv7l/binutils-2.40-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.40_i686/binutils-2.40-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.40_x86_64/binutils-2.40-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a0b2e49e2c1845b93e783543aab4e5870a80492b0daae013acff32a3737d2dbf',
     armv7l: 'a0b2e49e2c1845b93e783543aab4e5870a80492b0daae013acff32a3737d2dbf',
       i686: '3c297c16f332328a87e39186afa98ecc733a5f5a31fa02d3c91fb3a2b15f8040',
     x86_64: '8c63236295e9a7e427b06323f313c35cdeae3a7bf13f7e8738edf37f49d2b14e'
  })

  depends_on 'elfutils' # R
  depends_on 'flex' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R
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
  end

  def self.build
    # gprofng is broken on i686 in binutils 2.40
    # https://sourceware.org/bugzilla/show_bug.cgi?id=30006
    @gprofng = ARCH == 'i686' ? '--disable-gprofng' : ''
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "../configure #{CREW_OPTIONS} \
        --disable-bootstrap \
        --disable-maintainer-mode \
        #{@gprofng} \
        --enable-64-bit-bfd \
        --enable-gold=default \
        --enable-install-libiberty \
        --enable-ld \
        --enable-lto \
        --enable-plugins \
        --enable-relro \
        --enable-shared \
        --enable-threads \
        --enable-vtable-verify \
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
      system 'make check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}",
             "tooldir=#{CREW_PREFIX}", 'install'
    end
  end
end
