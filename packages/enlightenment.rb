require 'package'

class Enlightenment < Package
  description 'Enlightenment desktop shell'
  homepage 'https://enlightenment.org'
  version '0.24.1'
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/apps/enlightenment/enlightenment-0.24.1.tar.xz'
  source_sha256 'aee2b6178c918d71ebe661129f4008d773e70e5784651dadbcf56eec0a6d4a09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/enlightenment-0.24.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/enlightenment-0.24.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/enlightenment-0.24.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/enlightenment-0.24.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '128eacd09df52d7aafb76a53387591660f12a0e7d5b52ee20f0c0d15940f624b',
     armv7l: '128eacd09df52d7aafb76a53387591660f12a0e7d5b52ee20f0c0d15940f624b',
       i686: 'fe5bce7195a74539cfbb4391bdf65fcd57b9970c018d40fa47a73953311174af',
     x86_64: 'caff7dce9419868c7c3b23729d08ac7774163a16c0698dfcf8c2260c9ec36de6',
  })

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
