require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.39.7'
  source_url 'https://download.gnome.org/sources/vala/0.39/vala-0.39.7.tar.xz'
  source_sha256 'a54ec96125fdb63dbf96a8a3a65df41fdd88a617c1354088b5e10f8f0c89914d'

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
