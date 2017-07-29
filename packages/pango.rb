require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.40.0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.40/pango-1.40.0.tar.xz'
  source_sha256 'da17985df314cb07d066ab5424f59c21ce973ece05b7de4df04d798ec8511c8b'

  depends_on 'freetype'
  depends_on 'fontconfig'
  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
