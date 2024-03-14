require 'buildsystems/autotools'

class Gfbgraph < Autotools
  description 'GLib/GObject wrapper for the Facebook Graph API'
  homepage 'https://wiki.gnome.org/Projects/GFBGraph'
  version '0.2.4'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/libgfbgraph/-/archive/v_#{version.gsub(/[.]/, '_')}/libgfbgraph-v_#{version.gsub(/[.]/, '_')}.tar.bz2"
  source_sha256 'e55bb497daabfcd7e68e216ac5c695f03319f660ff524d0b6659e42089853516'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '883a3eb50bf0fd391333759913e20c4211f5f31a1a3002b7b900019b234b211d',
     armv7l: '883a3eb50bf0fd391333759913e20c4211f5f31a1a3002b7b900019b234b211d',
     x86_64: '560bd5f25612d861a0daea31a7547a0d8d18e42a9d21bcd7960dceef1b3ca7b5'
  })

  depends_on 'gnome_online_accounts'
  depends_on 'rest' => :build
  depends_on 'json_glib' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build

  gnome

  configure_options '--enable-gtk-doc \
    --enable-introspection'

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install \
    libgfbgraphdocdir=#{CREW_PREFIX}/share/doc/gfbgraph"
  end
end
