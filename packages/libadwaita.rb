require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.1.0-aab6'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita/-/archive/aab6c89993dbf9231e0aeec9d31ce35c52ea04a2/libadwaita-aab6c89993dbf9231e0aeec9d31ce35c52ea04a2.tar.bz2'
  source_sha256 'af4e34b811c18f2e42f76764c33f835b63110f8a1d471156befcd500d062daab'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libadwaita-1.1.0-aab6-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libadwaita-1.1.0-aab6-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libadwaita-1.1.0-aab6-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libadwaita-1.1.0-aab6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '50e69b5c70875b5d938f9d578fd786eed3ce1de4ca4ab0d788eac24dcf63788c',
     armv7l: '50e69b5c70875b5d938f9d578fd786eed3ce1de4ca4ab0d788eac24dcf63788c',
       i686: 'd68dd1fb68393dbeed3f7537a81d5812cc3cdff659dc74dfd07592a1cacad297',
     x86_64: 'c6e0ebffb33a5c57fb9dfcd94e66e9c4c2a7c354427405ab424c9f205a97e4aa'
  })

  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene'
  depends_on 'gtk4'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala' => :build

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto/g' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Drequire_all_tests=false \
      -Duser_documentation=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
