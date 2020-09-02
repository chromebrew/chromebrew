require 'package'

class Terminology < Package
  description 'Enlightenments terminal emulator'
  homepage 'https://www.enlightenment.org'
  version '1.8.0'
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/apps/terminology/terminology-1.8.0.tar.xz'
  source_sha256 'c6f5b003412f25507277702cabe1a11d7190971343c1d6030aa7d3fe5b45765f'

  depends_on 'desktop_file_utilities'
  depends_on 'xdg_utils'
  depends_on 'libefl'
  depends_on 'sommelier'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build"
    system 'ninja -v -C _build'
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
