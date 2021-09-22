require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.37'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 '820d9724f020a3e69cb337893a0b63c2db161dadcb0e06fc11dc29eb1e84a32c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37_armv7l/binutils-2.37-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37_armv7l/binutils-2.37-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37_i686/binutils-2.37-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.37_x86_64/binutils-2.37-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0acc9160cb2b55fbbd289c25da3b8f0684e02efb6ab16b7aaff2f0fcb6fb8cef',
     armv7l: '0acc9160cb2b55fbbd289c25da3b8f0684e02efb6ab16b7aaff2f0fcb6fb8cef',
       i686: '9735a35796db89f36df9ff4cd615e0d030aec2be566b8e3ab4ec8f011a89e1eb',
     x86_64: '6648a5f4b57cc1b93166920d48ff9ff2318e9eb834984d8511eaa2a4d992da83'
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
      system "#{CREW_ENV_OPTIONS} \
        ../configure #{CREW_OPTIONS} \
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
