require 'package'

class Telepathy_glib < Package
  description 'A library for GLib-based Telepathy components.'
  homepage 'https://telepathy.freedesktop.org/'
  version '0.24.1'
  compatibility 'all'
  source_url 'https://telepathy.freedesktop.org/releases/telepathy-glib/telepathy-glib-0.24.1.tar.gz'
  source_sha256 '9e0df1d8f857e0270cf0b32e2d1ca5a24aa7282873361785d573f72ad7f7d5eb'

  depends_on 'dbus_glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  
  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
            --enable-gtk-doc \
            --enable-introspection \
            --enable-vala-bindings"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
