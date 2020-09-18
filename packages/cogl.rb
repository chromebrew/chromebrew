require 'package'

class Cogl < Package
  description 'Library for using 3D graphics hardware for rendering'
  homepage 'https://www.clutter-project.org'
  version '1.22.8'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/cogl/1.22/cogl-1.22.8.tar.xz'
  source_sha256 'a805b2b019184710ff53d0496f9f0ce6dcca420c141a0f4f6fcc02131581d759'

  depends_on 'libxcomposite'
  depends_on 'libxrandr'
  depends_on 'mesa'
  depends_on 'pango'
  depends_on 'gdk_pixbuf'
  depends_on 'gst_plugins_base'
  depends_on 'wayland'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  def self.build
      system "./configure #{CREW_OPTIONS} --enable-cairo=yes --enable-cogl-pango=yes --enable-gdk-pixbuf=yes --enable-cogl-gst=yes  --enable-kms-egl-platform --enable-wayland-egl-platform --enable-wayland-egl-server"
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
