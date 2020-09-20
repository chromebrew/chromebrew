require 'package'

class Cogl < Package
  description 'Library for using 3D graphics hardware for rendering'
  homepage 'https://www.clutter-project.org'
  version '1.22.8'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/cogl/1.22/cogl-1.22.8.tar.xz'
  source_sha256 'a805b2b019184710ff53d0496f9f0ce6dcca420c141a0f4f6fcc02131581d759'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cogl-1.22.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cogl-1.22.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cogl-1.22.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cogl-1.22.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '43ec43e1186c754119bf75e1414e32ddf79d6ee17dd8a3d63ca55765d715d3da',
     armv7l: '43ec43e1186c754119bf75e1414e32ddf79d6ee17dd8a3d63ca55765d715d3da',
       i686: '075ad591bf9ce1c54c19efd07936cba00b9488660d9b62a1308217c0e35e9299',
     x86_64: '866c2dbd788c46ffc48b903d6d4732f6f5646f1c9c18959fce21a2dbe0d382cc',
  })

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
