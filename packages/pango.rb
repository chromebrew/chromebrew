require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.40.9'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.40/pango-1.40.9.tar.xz'
  source_sha256 '9faea6535312fe4436b93047cf7a04af544eb52a079179bd3a33821aacce7e16'

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
