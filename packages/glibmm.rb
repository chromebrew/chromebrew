require 'package'

class Glibmm < Package
  description 'Glibmm package is a set of C++ bindings for GLib'
  homepage 'https://www.gtkmm.org/en/'
  version '2.54.1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glibmm/2.54/glibmm-2.54.1.tar.xz'
  source_sha256 '7cc28c732b04d70ed34f0c923543129083cfb90580ea4a2b4be5b38802bf6a4a'

  depends_on 'glib'
  depends_on 'libsigcplusplus'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/glibmm-2.54.1/' \
    -i docs/Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
