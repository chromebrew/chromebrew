require 'package'

class Glibmm < Package
  description 'Glibmm package is a set of C++ bindings for GLib'
  homepage 'https://www.gtkmm.org/en/'
  version '2.57.1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glibmm/2.57/glibmm-2.57.1.tar.xz'
  source_sha256 'b98a9ea2ed5ea0a62d908182974e8a049fe7a890aad525b44a28bb5e44ca0d4c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'libsigcplusplus3'
  depends_on 'mm_common' => :build

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/glibmm-2.56.0/' \
    -i docs/Makefile.am"
    ENV['CFLAGS'] = "-std=c++17"
    system "./autogen.sh",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
