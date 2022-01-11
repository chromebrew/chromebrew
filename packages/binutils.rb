require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.37'
  version "#{@_ver}-1"
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 '820d9724f020a3e69cb337893a0b63c2db161dadcb0e06fc11dc29eb1e84a32c'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37-1_i686/binutils-2.37-1-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37-1_armv7l/binutils-2.37-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37-1_armv7l/binutils-2.37-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37-1_x86_64/binutils-2.37-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '9bd786abf5e42b06e3ecd51ffdd63348fbf54f18fd6aeec8aafcebc20f231404',
    aarch64: '2b0dccac7104572bd7e050ba191fc5eb355019351cba9d07293bb53450b4ff84',
     armv7l: '2b0dccac7104572bd7e050ba191fc5eb355019351cba9d07293bb53450b4ff84',
     x86_64: 'd9e0347631803d94648495ba9f2b16836f6f637046ac4c757a725c47f57a2c7a'
  })

  def self.prebuild
    FileUtils.rm_f "#{CREW_LIB_PREFIX}/libiberty.a"
  end

  def self.patch
    system 'filefix'
    system "sed -i 's,scriptdir = \$(tooldir)/lib,scriptdir = \$(tooldir)/#{ARCH_LIB},g' ld/Makefile.am"
    Dir.chdir 'ld' do
      system 'aclocal && automake'
    end
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "../configure #{CREW_OPTIONS} \
        --disable-bootstrap \
        --disable-maintainer-mode \
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
        --with-pic \
        --with-lib-path=#{CREW_LIB_PREFIX} \
        --with-system-zlib"
      system 'make configure-host'
      system "make tooldir=#{CREW_PREFIX}"
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
