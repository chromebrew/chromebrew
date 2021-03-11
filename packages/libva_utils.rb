require 'package'

class Libva_utils < Package
  description 'Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.10.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/intel/libva-utils/archive/#{@_ver}.tar.gz"
  source_sha256 'cbb7f9f6eae21d772e31b67bc8c311be6e35fe9c65e63acc57f9b16d72bf8dc0'

  depends_on 'libva'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
