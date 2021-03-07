require 'package'

class Telepathy_logger < Package
  description 'A library for GLib-based Telepathy components.'
  homepage 'https://telepathy.freedesktop.org/'
  version '0.8.2'
  compatibility 'all'
  source_url 'https://telepathy.freedesktop.org/releases/telepathy-logger/telepathy-logger-0.8.2.tar.bz2'
  source_sha256 '8fcad534d653b1b365132c5b158adae947810ffbae9843f72dd1797966415dae'

  depends_on 'dbus_glib'
  depends_on 'libx11'
  depends_on 'gobject_introspection'
  depends_on 'telepathy_glib'
  depends_on 'python27' => :build
  
  def self.build
    system "env PYTHON=python2.7 \
            ./configure #{CREW_OPTIONS} \
            --disable-gtk-doc \
            --enable-introspection \
            --enable-public-extensions \
            --with-x"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
  
  def self.check
    system "make check"
  end
end
