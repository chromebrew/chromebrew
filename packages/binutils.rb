require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.36.1'
  version "#{@_ver}-2"
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 'e81d9edf373f193af428a0f256674aea62a9d74dfe93f65192d4eae030b0f3b0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-2_armv7l/binutils-2.36.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-2_armv7l/binutils-2.36.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-2_i686/binutils-2.36.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-2_x86_64/binutils-2.36.1-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '46564bc989d33c3518f7afbb54f95e4b614f735ddcbe783114ba397ff283e408',
     armv7l: '46564bc989d33c3518f7afbb54f95e4b614f735ddcbe783114ba397ff283e408',
       i686: 'e9ea43c0c5f9f98422f83b8f1732104c78b55f53572e7353657944fe9dc6298a',
     x86_64: '784c5e9bfd884c411708ae3c2ee1c852022f411794ff109fb7d37e91f124037b'
  })

  depends_on 'flex'

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
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
        LDFLAGS='-flto=auto' \
        ../configure #{CREW_OPTIONS} \
        --disable-bootstrap \
        --disable-maintainer-mode \
        --enable-64-bit-bfd \
        --enable-gold \
        --enable-install-libiberty \
        --enable-ld=default \
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
