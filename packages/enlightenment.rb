require 'package'

class Enlightenment < Package
  description 'Enlightenment desktop shell'
  homepage 'https://enlightenment.org'
  version '0.24.1'
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/apps/enlightenment/enlightenment-0.24.1.tar.xz'
  source_sha256 'aee2b6178c918d71ebe661129f4008d773e70e5784651dadbcf56eec0a6d4a09'

  depends_on 'libefl'
  depends_on 'openpam'
  depends_on 'xkeyboard_config'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'xkeyboard_config'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build -Dbluez4=false -Dsystemd=false"
    system 'ninja -v -C _build'
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
