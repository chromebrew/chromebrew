require 'buildsystems/autotools'

class Gfbgraph < Autotools
  description 'GLib/GObject wrapper for the Facebook Graph API'
  homepage 'https://wiki.gnome.org/Projects/GFBGraph'
  version '0.2.5'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgfbgraph.git'
  git_hashtag "v_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '883a3eb50bf0fd391333759913e20c4211f5f31a1a3002b7b900019b234b211d',
     armv7l: '883a3eb50bf0fd391333759913e20c4211f5f31a1a3002b7b900019b234b211d',
     x86_64: '560bd5f25612d861a0daea31a7547a0d8d18e42a9d21bcd7960dceef1b3ca7b5'
  })

  depends_on 'gnome_online_accounts' => :build
  depends_on 'rest' => :build
  depends_on 'json_glib' => :build
  depends_on 'gobject_introspection' => :build

  gnome

  configure_options '--disable-gtk-doc \
    --enable-introspection'

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install \
    libgfbgraphdocdir=#{CREW_PREFIX}/share/doc/gfbgraph"
  end
end
