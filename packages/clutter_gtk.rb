require 'package'

class Clutter_gtk < Package
  description 'The Clutter Gtk package is a library providing facilities to integrate Clutter into GTK+ applications.'
  homepage 'https://wiki.gnome.org/Projects/Clutter'
  @_ver = '1.8.4'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/clutter-gtk/#{@_ver.rpartition('.')[0]}/clutter-gtk-#{@_ver}.tar.xz"
  source_sha256 '521493ec038973c77edcb8bc5eac23eed41645117894aaee7300b2487cb42b06'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clutter_gtk/1.8.4-1_armv7l/clutter_gtk-1.8.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clutter_gtk/1.8.4-1_armv7l/clutter_gtk-1.8.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clutter_gtk/1.8.4-1_i686/clutter_gtk-1.8.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clutter_gtk/1.8.4-1_x86_64/clutter_gtk-1.8.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3cdcfa7c4bf98dc60b0939a73d3923e693b7a11cfdde467083f10c4e4f667acd',
     armv7l: '3cdcfa7c4bf98dc60b0939a73d3923e693b7a11cfdde467083f10c4e4f667acd',
       i686: 'cf3612eb5b31a6d76c58a591b64860b97cba4a6bc74b256e5da8ad254028d24a',
     x86_64: '2a8db50e68fe70587de8a809ae5e114408b8ac6ce24224dc0dff657ce8b796a4'
  })

  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'
  depends_on 'valgrind' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
