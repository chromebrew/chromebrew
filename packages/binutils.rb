require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.36.1'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 'e81d9edf373f193af428a0f256674aea62a9d74dfe93f65192d4eae030b0f3b0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '22a88c3eb29672805441c78fa2c37414a4d49bec790252391c1caf45edc20426',
     armv7l: '22a88c3eb29672805441c78fa2c37414a4d49bec790252391c1caf45edc20426',
       i686: '7f47210024759db0485292d7695f46532ae0c4c579c03ba0c6450a5174ce9f6f',
     x86_64: '624fb52ce022d6caea7c99a8c6a08f872e51fe0c8be09bb3c3f72e186ad60d3a'
  })

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
