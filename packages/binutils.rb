require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.36.1'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 'e81d9edf373f193af428a0f256674aea62a9d74dfe93f65192d4eae030b0f3b0'

  def self.build
    system 'filefix'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
        LDFLAGS='-flto=auto' \
        ../configure #{CREW_OPTIONS} \
        --with-system-zlib \
        --disable-maintainer-mode \
        --enable-shared \
        --enable-gold \
        --enable-ld=default \
        --enable-plugins \
        --disable-bootstrap \
        --enable-64-bit-bfd \
        --enable-lto \
        --enable-vtable-verify \
        --enable-install-libiberty"
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
