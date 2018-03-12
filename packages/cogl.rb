require 'package'

class Cogl < Package
  description 'A library for using 3D graphics hardware to draw pretty pictures.'
  homepage 'https://www.cogl3d.org/'
  version '1.22.2'
  source_url 'https://download.gnome.org/sources/cogl/1.22/cogl-1.22.2.tar.xz'
  source_sha256 '39a718cdb64ea45225a7e94f88dddec1869ab37a21b339ad058a9d898782c00d'

  depends_on 'gdk_pixbuf'
  depends_on 'libdrm'
  depends_on 'libxcomposite'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxrandr'
  depends_on 'mesa'
  depends_on 'pango'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'glib'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    system "pip uninstall --yes six"
  end
  
end
