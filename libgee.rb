require 'package'

class Libgee < Package
  description 'GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  version '0.18.0'
  source_url 'https://download.gnome.org/sources/libgee/0.18/libgee-0.18.0.tar.xz'
  source_sha256 '4ad99ef937d071b4883c061df40bfe233f7649d50c354cf81235f180b4244399'

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'vala'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
