require 'package'

class Libsecret < Package
  description 'GObject based library for accessing the Secret Service API.'
  homepage 'https://github.com/GNOME/libsecret'
  version '0.20.4'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libsecret/archive/0.20.4.tar.gz'
  source_sha256 'ca34e69b210df221ae5da6692c2cb15ef169bb4daf42e204442f24fdb0520d4b'


  depends_on 'gobject_introspection' => :build
  depends_on 'libgcrypt' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dgtk_doc=false -Dmanpage=false build"
    system 'meson configure build'
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
