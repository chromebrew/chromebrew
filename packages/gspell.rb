require 'package'

class Gspell < Package
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.12.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/gspell/1.12/gspell-1.12.1.tar.xz'
  source_sha256 '8ec44f32052e896fcdd4926eb814a326e39a5047e251eec7b9056fbd9444b0f1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.12.1_armv7l/gspell-1.12.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.12.1_armv7l/gspell-1.12.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gspell/1.12.1_x86_64/gspell-1.12.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5fe8ce8680328b2b48b5466536bca49f6b8dac7070dcc75cd361f24702bf5a70',
     armv7l: '5fe8ce8680328b2b48b5466536bca49f6b8dac7070dcc75cd361f24702bf5a70',
     x86_64: 'ab91f8ec9eb2da5593b53ccd9fac252e50666aede63a248f572c3f0c5954b426'
  })

  depends_on 'aspell' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
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
