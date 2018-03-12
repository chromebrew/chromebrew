require 'package'

class Clutter < Package
  description 'Clutter is a library for creating graphical user interfaces. https://wiki.gnome.org/Projects/Clutter'
  homepage 'https://download.gnome.org/sources/clutter/'
  version '1.26.2'
  source_url 'https://download.gnome.org/sources/clutter/1.26/clutter-1.26.2.tar.xz'
  source_sha256 'e7233314983055e9018f94f56882e29e7fc34d8d35de030789fdcd9b2d0e2e56'

  depends_on 'cogl'
  depends_on 'gtk3'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'gobject_introspection'
  depends_on 'atk'
  depends_on 'glib'
  depends_on 'json_glib'
  depends_on 'libdrm'
  depends_on 'cairo'
  depends_on 'pango'
  depends_on 'libxkbcommon'
  depends_on 'libxext'
  depends_on 'libxdamage'
  depends_on 'inputproto'
  depends_on 'libxcomposite'
  depends_on 'gdk_pixbuf'

  def self.build
    system "./configure --enable-egl-backend=no --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    system "pip uninstall --yes six"
  end
  
end
