require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers. https://wiki.gnome.org/Projects/Vala'
  homepage 'https://download.gnome.org/sources/vala/'
  version '0.40.0'
  source_url 'https://download.gnome.org/sources/vala/0.40/vala-0.40.0.tar.xz'
  source_sha256 '15888fcb5831917cd67367996407b28fdfc6cd719a30e6a8de38a952a8a48e71'

  depends_on 'flex'
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
