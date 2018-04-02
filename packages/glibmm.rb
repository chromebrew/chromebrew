require 'package'

class Glibmm < Package
  description 'Glibmm package is a set of C++ bindings for GLib'
  homepage 'https://www.gtkmm.org/en/'
  version '2.56.0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glibmm/2.56/glibmm-2.56.0.tar.xz'
  source_sha256 '6e74fcba0d245451c58fc8a196e9d103789bc510e1eee1a9b1e816c5209e79a9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0da9d1c303e930b3032ef6a341074990a7b3a2150807bb23b4d58fb040d6239e',
     armv7l: '0da9d1c303e930b3032ef6a341074990a7b3a2150807bb23b4d58fb040d6239e',
       i686: '33f2ee3459c31930ba5fb2ba926fb1b9df57ccf3573a356bc1ba0cf4717157e1',
     x86_64: 'ff20a28d6d3cbd4267bc442d774be4b7ddcd4e48f252d9974d598ee1e93fee82',
  })

  depends_on 'glib'
  depends_on 'libsigcplusplus' # sigc++-2.0
  depends_on 'libsigcplusplus3' # sigc++-3.0
  depends_on 'mm_common' => :build

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/glibmm-2.56.0/' \
    -i docs/Makefile.in"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
