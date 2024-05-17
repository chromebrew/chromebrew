require 'buildsystems/meson'

class Tepl_5 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://gitlab.gnome.org/Archive/tepl'
  version '5.1.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/Archive/tepl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    i686: '380fcc1fba9345a966726985dd7232d5bf1326bf62597f43b2bd194a40ce4a91',
    aarch64: '97a15b8de54e7dc76f5ca6ec9c39979149006476ffc104ac9fb2ac5dc6327a40',
     armv7l: '97a15b8de54e7dc76f5ca6ec9c39979149006476ffc104ac9fb2ac5dc6327a40',
     x86_64: '086ee11f0ddce8037611b8cfa0388e35687d9306944f9e809387e3dd227f5531'
  })

  depends_on 'amtk' # R
  depends_on 'cairo' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_4' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'vala' => :build

  gnome
end
