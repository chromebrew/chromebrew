require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.11.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gspell/1.11/gspell-1.11.1.tar.xz'
  source_sha256 'ef6aa4e3f711775158a7e241a5f809cf2426bc0e02c23a7d2b5c71fc3de00292'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.11.1_armv7l/gspell-1.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.11.1_armv7l/gspell-1.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.11.1_i686/gspell-1.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.11.1_x86_64/gspell-1.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '999fe1c06d6e8e31c81b2ee2888ff8bafe16f7d53788ca89e392eea3e603265a',
     armv7l: '999fe1c06d6e8e31c81b2ee2888ff8bafe16f7d53788ca89e392eea3e603265a',
       i686: 'cdc82e95dc15437ace47c4a5c0495faf42b509fab2c9c3d8b69ba2f6903dafc0',
     x86_64: '02635107c3109e0cf091272c9e1acf7b98ea1640a90e711c0d52561e0d75cae5'
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
  depends_on 'aspell' # R
  depends_on 'atk_spi2_core' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

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
