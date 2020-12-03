require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  version '1.9.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gspell/1.9/gspell-1.9.1.tar.xz'
  source_sha256 'dcbb769dfdde8e3c0a8ed3102ce7e661abbf7ddf85df08b29915e92cd723abdd'

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
