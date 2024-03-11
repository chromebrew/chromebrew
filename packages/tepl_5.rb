require 'package'

class Tepl_5 < Package
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  @_ver = '5.0.1'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/Archive/tepl.git'
  git_hashtag @_ver
  binary_compression 'tpxz'

  binary_sha256({
    i686: '380fcc1fba9345a966726985dd7232d5bf1326bf62597f43b2bd194a40ce4a91',
    aarch64: '720a58a348b85529676c8bd4caa1a1e1566e3afbbcb01017bd91808242c955d0',
     armv7l: '720a58a348b85529676c8bd4caa1a1e1566e3afbbcb01017bd91808242c955d0',
     x86_64: '347c0d84339c38b72332b8b91e468f85e72a69e5b13ceb5e689d49332f337c99'
  })

  depends_on 'amtk'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
