require 'package'

class Glibmm < Package
  description 'Glibmm package is a set of C++ bindings for GLib'
  homepage 'https://www.gtkmm.org/en/'
  version '2.56.0-0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glibmm/2.56/glibmm-2.56.0.tar.xz'
  source_sha256 '6e74fcba0d245451c58fc8a196e9d103789bc510e1eee1a9b1e816c5209e79a9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.56.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '734ea5bce78ffef9ad52a2d7503b55b2bb47cbe743142c371ac68cb543df4343',
     armv7l: '734ea5bce78ffef9ad52a2d7503b55b2bb47cbe743142c371ac68cb543df4343',
       i686: 'c88a048055070b1c14c296f49eb20333a6ffe4a8e4c37fdab06990fd798b6b87',
     x86_64: '3c30713258dd4972d7118024d44e09f87e1eeea466dfc4b72cb5bb8ea19347bc',
  })

  depends_on 'glib'
  depends_on 'libsigcplusplus' # sigc++-2.0
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
