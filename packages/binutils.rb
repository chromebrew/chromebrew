require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.36.1'
  version "#{@_ver}-1"
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 'e81d9edf373f193af428a0f256674aea62a9d74dfe93f65192d4eae030b0f3b0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3f580f50aa890e57b2faead8c500982890b03c834a0808d1ee8fbf8f91df706f',
     armv7l: '3f580f50aa890e57b2faead8c500982890b03c834a0808d1ee8fbf8f91df706f',
       i686: '791e202c0fa73426b35ba072f4bd7d08150792d56ed0a55fd92921373eeef1ed',
     x86_64: '564af95307c729f0199717dbb770a7dae08c3cb3818298689f809076c45fa9c5'
  })

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
