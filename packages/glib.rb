require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C. https://developer.gnome.org/glib'
  homepage 'https://download.gnome.org/sources/glib/'
  version '2.56.0'
  source_url 'https://download.gnome.org/sources/glib/2.56/glib-2.56.0.tar.xz'
  source_sha256 'ecef6e17e97b8d9150d0e8a4b3edee1ac37331213b8a2a87a083deea408a0fc7'

  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'util_linux'
  depends_on 'zlibpkg'
  depends_on 'python27'

  def self.build
    system "sh autogen.sh --with-libiconv"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-libiconv --with-pcre"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
