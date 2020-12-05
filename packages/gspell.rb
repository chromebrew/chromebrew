require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  version '1.9.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gspell/1.9/gspell-1.9.1.tar.xz'
  source_sha256 'dcbb769dfdde8e3c0a8ed3102ce7e661abbf7ddf85df08b29915e92cd723abdd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b804ca54e3ff7f007d078c1a3f329b67131f7e4fe2fb72d835c2d93762093c7b',
     armv7l: 'b804ca54e3ff7f007d078c1a3f329b67131f7e4fe2fb72d835c2d93762093c7b',
       i686: 'b05c30504de2f207fca5f4ff92fff5294db9d1479b0404028b5345c972cea38e',
     x86_64: 'f7c41e8c5b900aa694b002f5134b89d9c9757e7e5f56c060b7f308fb146dd5dc',
  })

  depends_on 'gtk3'
  depends_on 'enchant'
  depends_on 'libxml2'
  depends_on 'iso_codes'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gtk_doc' => ':build'

  ENV['CC'] = "clang"
  ENV['CXX'] = "clang"
  ENV['XML_CATALOG_FILES'] = "#{CREW_PREFIX}/etc/xml/catalog"

  def self.build
    system "./configure --help"
    system "./configure  #{CREW_OPTIONS} --enable-gtk-doc-html=no"
    system "make"
  end
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
