require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib/'
  version '2.53.4'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.53/glib-2.53.4.tar.xz'
  source_sha256 'f26b5565f9c1deba2d76dd5f819f9ed248dd75fcd19aa9fa6f51c5f554790679'

  depends_on 'libffi'
  depends_on 'gettext'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
