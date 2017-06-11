require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.40.0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.40/pango-1.40.0.tar.xz'
  source_sha1 '5e1394f2c063747593cb8157ebd953103b8000d2'

  depends_on 'freetype'
  depends_on 'fontconfig'
  depends_on 'harfbuzz'
  depends_on 'cairo'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
