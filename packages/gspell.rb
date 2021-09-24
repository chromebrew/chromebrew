require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.9.1-2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gspell/1.9/gspell-1.9.1.tar.xz'
  source_sha256 'dcbb769dfdde8e3c0a8ed3102ce7e661abbf7ddf85df08b29915e92cd723abdd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.9.1-2_armv7l/gspell-1.9.1-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.9.1-2_armv7l/gspell-1.9.1-2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.9.1-2_x86_64/gspell-1.9.1-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b3d710b9a07b831b1d7b771bd563367e5ebf40adb880238824c4a906ba3118bb',
     armv7l: 'b3d710b9a07b831b1d7b771bd563367e5ebf40adb880238824c4a906ba3118bb',
     x86_64: 'e5f3df2f932455279ab3cd4ac3828684644524e39e4a53c6b54de62c30e2ad2b'
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
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} \
      ./configure  #{CREW_OPTIONS} --enable-gtk-doc-html=no"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
