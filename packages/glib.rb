require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.54.3'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.54/glib-2.54.3.tar.xz'
  source_sha256 '963fdc6685dc3da8e5381dfb9f15ca4b5709b28be84d9d05a9bb8e446abac0a8'


  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'util_linux'
  depends_on 'zlibpkg'
  depends_on 'python27'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-pcre"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
