require 'package'

class Libfontenc < Package
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libfontenc-1.1.4.tar.bz2'
  source_sha256 '2cfcce810ddd48f2e5dc658d28c1808e86dcf303eaff16728b9aa3dbc0092079'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfontenc-1.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '61404455c82859773af6254eeb7f7fa046535b153633598058514f8947bdf215',
     armv7l: '61404455c82859773af6254eeb7f7fa046535b153633598058514f8947bdf215',
       i686: '32ec43ea215a88f9419cad14cddb91bc47c3674aa010217b5891e5703fa94615',
     x86_64: 'cce2468f805c856b31762a8e58e06516c6aa5c178c1fcb11ed1efe85b854c9ed',
  })

  depends_on 'xorg_proto'
  depends_on 'zlibpkg'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
