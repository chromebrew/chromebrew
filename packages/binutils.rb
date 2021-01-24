require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.36'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 '173738b732af5d474f1809af0f5a84454a4fc20d620e931e080697e85f802312'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.36-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'fd86f02633b27be6d0eaf1ca5f30c0d1e93b4b6e0c08311972bf9f74892b1dcf',
      armv7l: 'fd86f02633b27be6d0eaf1ca5f30c0d1e93b4b6e0c08311972bf9f74892b1dcf',
        i686: '1ce06b9e18bd84abe16156e61a68f67e35c749d88733e8d6d69d8b4a14f1aa70',
      x86_64: '10738895b575f9a41a463c8d0a67a18ba0c134bdf71c9388c1a7d6706e5479fd',
  })

  depends_on 'filecmd'
  depends_on 'texinfo'

  def self.build
    system 'filefix'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
        ../configure #{CREW_OPTIONS} \
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
