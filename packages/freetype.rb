require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.11.0'
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.11.0.tar.xz'
  source_sha256 '8bee39bd3968c4804b70614a0a3ad597299ad0e824bc8aad5ce8aaf48067bde7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.0_armv7l/freetype-2.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.0_armv7l/freetype-2.11.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.0_x86_64/freetype-2.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '24c9fee8ddd769952dd1eb0927020892b61677f8097e8d70fccf7ee4902680e4',
     armv7l: '24c9fee8ddd769952dd1eb0927020892b61677f8097e8d70fccf7ee4902680e4',
     x86_64: '8a173447f2471d35512e6ea75cda0f53f18ae930e990881f94c7dbea9011b402'
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
