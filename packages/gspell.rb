require 'buildsystems/meson'

class Gspell < Meson
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version "1.14.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gspell.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b53c8bd835ca913e070beae76e935f7cfef3adc4934134ce1da150ca5895e09',
     armv7l: '2b53c8bd835ca913e070beae76e935f7cfef3adc4934134ce1da150ca5895e09',
     x86_64: '4d33ec34e9dd15c10bb618204cc7d3420e031da2b2bf08f397401920d7e5b38b'
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
  depends_on 'hunspell' # L
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
