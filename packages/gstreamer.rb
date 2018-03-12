require 'package'

class Gstreamer < Package
  description 'Open source multimedia framework. https://gstreamer.freedesktop.org/'
  homepage 'https://download.gnome.org/sources/gstreamer/'
  version '1.13.90'
  source_url 'https://download.gnome.org/sources/gstreamer/1.13/gstreamer-1.13.90.tar.xz'
  source_sha256 '4ffbd96a3ea1844212757be5609bbd16667f83c21db79a91f9da589c833258b0'

  depends_on 'glib'
  depends_on 'libcap'
  depends_on 'libunwind'
  depends_on 'libxml2'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'valgrind'
  depends_on 'gmp'
  depends_on 'gtk3'
  depends_on 'bison'
  depends_on 'flex'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
