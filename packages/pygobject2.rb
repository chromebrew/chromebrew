require 'package'

class Pygobject2 < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  version '2.28.7'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/pygobject/2.28/pygobject-2.28.7.tar.xz'
  source_sha256 'bb9d25a3442ca7511385a7c01b057492095c263784ef31231ffe589d83a96a5a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '3debe985d9c09730ec6e882a781cd02982a63bff5a9c709f306c6c93d0db30fd',
     armv7l: '3debe985d9c09730ec6e882a781cd02982a63bff5a9c709f306c6c93d0db30fd',
     x86_64: 'f8770f45903fe780f4e91f97e14616bbaf4d895ab924feae1b892529a98aa121'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'py3_pycairo'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
