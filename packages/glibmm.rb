require 'package'

class Glibmm < Package
  description 'Glibmm package is a set of C++ bindings for GLib'
  homepage 'https://www.gtkmm.org/en/'
  version '2.54.1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glibmm/2.54/glibmm-2.54.1.tar.xz'
  source_sha256 '7cc28c732b04d70ed34f0c923543129083cfb90580ea4a2b4be5b38802bf6a4a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.54.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.54.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.54.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.54.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '39666c439ca57f9d33837237e947baaad2c29397a01b1068fbf32060031b7cbf',
     armv7l: '39666c439ca57f9d33837237e947baaad2c29397a01b1068fbf32060031b7cbf',
       i686: '42322e7154ce7866f5b9ee5ca2d76bf395d78227f3061c5e80c9319836b01075',
     x86_64: '370bb7c2d5879238cb64d75878e2f6e99d1e67bfd3889c4e122b1c12ed9fba89',
  })

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
