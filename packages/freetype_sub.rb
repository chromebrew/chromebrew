require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.10.1'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.1.tar.xz'
  source_sha256 '16dbfa488a21fe827dc27eaf708f42f7aa3bb997d745d31a19781628c36ba26f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '61decfc0ca8f0e58eb496856b6ed89e124f5223ba95bcc1afdc21eca1a647b74',
     armv7l: '61decfc0ca8f0e58eb496856b6ed89e124f5223ba95bcc1afdc21eca1a647b74',
       i686: '78d772a1a74ae57272edf940bdbcf348a6e2abe7aa6f552c4176b9fd46311f72',
     x86_64: '8726f91f8884fe8875098d6cf2e323dcc79d50adeaa927d1092f87c4af961f44',
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  
  def self.build
    system 'pip3 install docwriter'
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS} --enable-freetype-config --without-harfbuzz"
    system 'make'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.postinstall
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar | xargs rm -rf"  # make sure to delete downloaded files
  end
end
