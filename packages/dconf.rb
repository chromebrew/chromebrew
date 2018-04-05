require 'package'

class Dconf < Package
  description 'The DConf package contains a low-level configuration system.'
  homepage 'https://wiki.gnome.org/Projects/dconf'
  version '0.28.0'
  source_url 'https://download.gnome.org/sources/dconf/0.28/dconf-0.28.0.tar.xz'
  source_sha256 '61d3b3865ef58b729c3b39aa0979f886c014aa8362f93dcfc74bf5648ed9c742'

  depends_on 'dbus'  => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib'  # version 2
  depends_on 'meson'  => :build
  depends_on 'vala'  => :build
  
  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
  
end
