require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.46.2'
  source_url 'https://download.gnome.org/sources/vala/0.46/vala-0.46.2.tar.xz'
  source_sha256 '92070393e8102da29e07b29fcb808d021600a25f8a2a69c852470ec8d97740bc'

  binary_url ({
  })
  binary_sha256 ({
  })

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
