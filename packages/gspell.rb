require 'buildsystems/meson'

class Gspell < Meson
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version "1.14.3-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gspell.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7135d2f5af0d2878628eb9e8c485a43337723dcd2ad466cd64d4806a6d59322',
     armv7l: 'd7135d2f5af0d2878628eb9e8c485a43337723dcd2ad466cd64d4806a6d59322',
     x86_64: '158a54386f25e8ca605d30d854a012321dc925b8261874d29f71687f43826185'
  })

  depends_on 'aspell' => :build
  depends_on 'autoconf_archive' => :build
  depends_on 'enchant' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' # R
  depends_on 'hunspell' => :logical
  depends_on 'icu4c' # R
  depends_on 'iso_codes' => :build
  depends_on 'libxml2' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'ncurses' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgobject_introspection=false \
                 -Dgtk_doc=false \
                 -Dtests=false \
                 -Dvapi=false'
end
