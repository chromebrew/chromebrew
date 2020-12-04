require 'package'

class Glib_networking < Package
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.66.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/glib-networking/archive/2.66.0.tar.gz'
  source_sha256 '186a670c00525d62aa160bc3e492d9efd2f59c540c50477982eb732ed62ee96c'


  depends_on 'libproxy'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'meson' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dstatic_modules=true builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
