require 'package'

class Gtk_vnc < Package
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gtk-vnc/1.0/gtk-vnc-1.0.0.tar.xz'
  source_sha256 'a81a1f1a79ad4618027628ffac27d3391524c063d9411c7a36a5ec3380e6c080'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_vnc-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_vnc-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_vnc-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_vnc-1.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8026b25e42c51f0a124aff3779b9dbb035b331dd2bb0faa60cf10f54a9e77b38',
     armv7l: '8026b25e42c51f0a124aff3779b9dbb035b331dd2bb0faa60cf10f54a9e77b38',
       i686: '86b2a47da79c0035ad41efb6ae4a0eb9bee0d931caf54ecbb44dd79183af5ee8',
     x86_64: 'efa9ae051e5ef07895101f66f93577fd459609b8eb3fd8bb6bc00ee76fd638d3',
  })

  depends_on 'pygtk'
  depends_on 'libcyrussasl'
  depends_on 'glib'
  depends_on 'libgcrypt'
  depends_on 'gobject_introspection'

  def self.prebuild
    system "sed -i '226d' meson.build"
  end

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --buildtype=release -Dwith-coroutine=auto _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
