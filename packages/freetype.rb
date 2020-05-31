require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.10.1'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.1.tar.xz'
  source_sha256 '16dbfa488a21fe827dc27eaf708f42f7aa3bb997d745d31a19781628c36ba26f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '227d47ee4d7b5cb50cbe4be8cec8be7125ebd28d96e649972aa8ba2e947a5fa2',
     armv7l: '227d47ee4d7b5cb50cbe4be8cec8be7125ebd28d96e649972aa8ba2e947a5fa2',
       i686: 'de195bd3d95afa2ba8e0ef7bf137d957037d41b356ee482f6b270e6cf0780780',
     x86_64: 'ccadfa7f9242639930dd5ae0fd9ac1609901ffefb33842c4dbd63f729f853a74',
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  depends_on 'harfbuzz'

  def self.build
    system 'pip3 install docwriter'
    system "sed -i 's,/usr/include/freetype2,#{CREW_PREFIX}/include/freetype2,g' configure"
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS} --enable-freetype-config --with-harfbuzz"
    system 'make'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
