require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.52.3'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.52/glib-2.52.3.tar.xz'
  source_sha256 '25ee7635a7c0fcd4ec91cbc3ae07c7f8f5ce621d8183511f414ded09e7e4e128'

  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'util_linux'
  depends_on 'zlibpkg'
  depends_on 'python27'

  def self.build
    system "./configure --with-pcre --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
