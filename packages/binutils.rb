require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '2.38'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/binutils/binutils-2.38.tar.xz'
  source_sha256 'e316477a914f567eccc34d5d29785b8b0f5a10208d36bbacedcc39048ecfe024'

  def self.prebuild
    FileUtils.rm_f "#{CREW_LIB_PREFIX}/libiberty.a"
  end

  def self.patch
    system 'filefix'
    system "sed -i 's,scriptdir = \$(tooldir)/lib,scriptdir = \$(tooldir)/#{ARCH_LIB},g' ld/Makefile.am"
    system 'cd ld/; aclocal && automake'
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system <<~BUILD
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
          --with-system-zlib
      BUILD

      system 'make configure-host'
      system "make tooldir=#{CREW_PREFIX}"
    end
  end

  def self.check
    system 'cd build; make check || true'
  end

  def self.install
    system "cd build; make DESTDIR=#{CREW_DEST_DIR} prefix=#{CREW_PREFIX} tooldir=#{CREW_PREFIX} install"
  end
end
