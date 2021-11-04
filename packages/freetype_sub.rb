require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.11.0'
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.11.0.tar.xz'
  source_sha256 '8bee39bd3968c4804b70614a0a3ad597299ad0e824bc8aad5ce8aaf48067bde7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.0_armv7l/freetype_sub-2.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.0_armv7l/freetype_sub-2.11.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.0_i686/freetype_sub-2.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.0_x86_64/freetype_sub-2.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7cb416b93f2b41dcef3f7fa9cc5624467e5cc89a720a2850b0edde19f48999b7',
     armv7l: '7cb416b93f2b41dcef3f7fa9cc5624467e5cc89a720a2850b0edde19f48999b7',
       i686: '1f83220dee2819353ce9fdf268397b969b9c368b6d4088d8e0a92772170eb0f3',
     x86_64: '5abc6e6e8c4b68d6e1e860f4a9b421578ed2b3a21180a3f2ac880af629ee2afd'
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'

  def self.build
    system 'pip3 install docwriter'
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS} --disable-freetype-config --without-harfbuzz"
    system 'make'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    ENV['CREW_CONFLICTS_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar | xargs rm -rf"  # make sure to delete downloaded files
  end
end
