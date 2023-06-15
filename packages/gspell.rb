require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.12.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/gspell/1.12/gspell-1.12.0.tar.xz'
  source_sha256 '40d2850f1bb6e8775246fa1e39438b36caafbdbada1d28a19fa1ca07e1ff82ad'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.12.0_armv7l/gspell-1.12.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.12.0_armv7l/gspell-1.12.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.12.0_x86_64/gspell-1.12.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b2079e4a8aaa0a0af5d2429423dc490ae5fcec4e454ebfd6f1a44c5d7bc8f57d',
     armv7l: 'b2079e4a8aaa0a0af5d2429423dc490ae5fcec4e454ebfd6f1a44c5d7bc8f57d',
     x86_64: '2974ec509d6966649fe4f11f84920e8f722c78510925d5a88046bd13d05f79f4'
  })

  depends_on 'aspell' # R
  depends_on 'at_spi2_core' # R
  depends_on 'enchant' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hunspell' # L
  depends_on 'icu4c' # R
  depends_on 'iso_codes' => :build
  depends_on 'libxml2' => :build
  depends_on 'llvm16_lib' => :build
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  ENV['XML_CATALOG_FILES'] = "#{CREW_PREFIX}/etc/xml/catalog"

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure  #{CREW_OPTIONS} --enable-gtk-doc-html=no"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
