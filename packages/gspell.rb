require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  version '1.9.1-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gspell/1.9/gspell-1.9.1.tar.xz'
  source_sha256 'dcbb769dfdde8e3c0a8ed3102ce7e661abbf7ddf85df08b29915e92cd723abdd'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gspell-1.9.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '26c16ee849e3c09cd67f6dd951fd917959d362d195d9e52d3efca4e1b6875328',
      armv7l: '26c16ee849e3c09cd67f6dd951fd917959d362d195d9e52d3efca4e1b6875328',
        i686: '6c1dc99a8c02e8e507950149823969c89100c96ca692603d534d4ed5b0a5f7b5',
      x86_64: 'ed611db95e4986659250615fce945abd25aadb908f819de371182525673b99e2',
  })

  depends_on 'gtk3'
  depends_on 'enchant'
  depends_on 'libxml2'
  depends_on 'iso_codes'
  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'llvm' => :build
  depends_on 'hunspell'

  ENV['XML_CATALOG_FILES'] = "#{CREW_PREFIX}/etc/xml/catalog"

  def self.patch
    # Fixes ./configure: /usr/bin/file: No such file or directory
    system 'filefix'
  end
  
  def self.build
    system "CFLAGS=-fuse-ld=lld \
    CXXFLAGS=-fuse-ld=lld \
    ./configure  #{CREW_OPTIONS} --enable-gtk-doc-html=no"
    system "make"
  end
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
