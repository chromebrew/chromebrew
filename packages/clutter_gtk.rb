require 'buildsystems/meson'

class Clutter_gtk < Meson
  description 'The Clutter Gtk package is a library providing facilities to integrate Clutter into GTK+ applications.'
  homepage 'https://wiki.gnome.org/Projects/Clutter'
  @_ver = '1.8.4'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://download.gnome.org/sources/clutter-gtk/#{@_ver.rpartition('.')[0]}/clutter-gtk-#{@_ver}.tar.xz"
  source_sha256 '521493ec038973c77edcb8bc5eac23eed41645117894aaee7300b2487cb42b06'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '3cdcfa7c4bf98dc60b0939a73d3923e693b7a11cfdde467083f10c4e4f667acd',
     armv7l: '3cdcfa7c4bf98dc60b0939a73d3923e693b7a11cfdde467083f10c4e4f667acd',
     x86_64: '2a8db50e68fe70587de8a809ae5e114408b8ac6ce24224dc0dff657ce8b796a4'
  })

  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'
  depends_on 'valgrind' => :build

  gnome
end
