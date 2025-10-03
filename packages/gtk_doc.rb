require 'buildsystems/meson'

class Gtk_doc < Meson
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.35.1'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-doc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0789f654479c3eaa8b60d10845fd8d9f9d96b4a4d32427ee7f492d77aedafae4',
     armv7l: '0789f654479c3eaa8b60d10845fd8d9f9d96b4a4d32427ee7f492d77aedafae4',
       i686: '593adbde82c3ea239ad23ad9a91a7ca61f5dc7188388b76d683d1fbf526323fa',
     x86_64: '83154a542e3b45fb0a516bfe706f38e71d137a137281c0f8eb41c4f570a91b92'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glib' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build

  gnome
end
