require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.11.0'
  license 'FTL or GPL-2+'
  compatibility 'x86_64'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.11.0.tar.xz'
  source_sha256 '8bee39bd3968c4804b70614a0a3ad597299ad0e824bc8aad5ce8aaf48067bde7'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.0_x86_64/freetype_sub-2.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '039810744e62693895f366e48f2ff9156b4a02c3784a4b7a851992dc94ded9a6'
  })

  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng

  def self.preflight
    @device = JSON.parse(File.read("#{CREW_CONFIG_PATH}device.json"), symbolize_names: true)
    if @device[:installed_packages].any? 'harfbuzz'
      abort 'This harfbuzz prereq needs to be built without harfbuzz installed.'.lightred
    end
  end

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
