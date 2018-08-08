require 'package'

class Dbus_glib < Package
  description 'The D-Bus GLib package contains GLib interfaces to the D-Bus API.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/general/dbus-glib.html'
  version '0.110'
  source_url 'https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.110.tar.gz'
  source_sha256 '7ce4760cf66c69148f6bd6c92feaabb8812dee30846b24cd0f7395c436d7e825'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk_doc'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
