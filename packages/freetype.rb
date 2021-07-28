require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.11.0'
  license 'FTL or GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.11.0.tar.xz'
  source_sha256 '8bee39bd3968c4804b70614a0a3ad597299ad0e824bc8aad5ce8aaf48067bde7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.0_armv7l/freetype-2.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.0_armv7l/freetype-2.11.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.0_x86_64/freetype-2.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c08cf688f4f1ef885f349da0334de39cecdb20747465687065d95e03465c58d1',
     armv7l: 'c08cf688f4f1ef885f349da0334de39cecdb20747465687065d95e03465c58d1',
     x86_64: '395ed9c9be0c260428f1588ddce0a969bdfaab0c664c67f6518278610622a6d1'
  })

  depends_on 'harfbuzz'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng

  def self.patch
    system 'sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg'
    system 'sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h'
  end

  def self.build
    system 'pip3 install docwriter'
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end

  def self.postinstall
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar | xargs rm -rf"  # make sure to delete downloaded files
  end
end
