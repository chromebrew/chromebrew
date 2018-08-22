require 'package'

class Gexiv2 < Package
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.10.8'
  source_url 'https://download.gnome.org/sources/gexiv2/0.10/gexiv2-0.10.8.tar.xz'
  source_sha256 '81c528fd1e5e03577acd80fb77798223945f043fd1d4e06920c71202eea90801'

  depends_on 'libexiv2'
  depends_on 'gobject_introspection'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
