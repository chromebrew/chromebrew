require 'buildsystems/meson'

class Gspell < Meson
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version "1.13.1-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gspell.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ac757e5b1395d38c5c0e71c73520221da80ba1eece3e1b9a193af908ca32fae',
     armv7l: '6ac757e5b1395d38c5c0e71c73520221da80ba1eece3e1b9a193af908ca32fae',
     x86_64: '1bd1ceda2c88ffb2885beba6cec7583e0efb16e4478d9be67b7e4e630461123c'
  })

  depends_on 'aspell' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'autoconf_archive' => :build
  depends_on 'cairo' # R
  depends_on 'enchant' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hunspell' # L
  depends_on 'icu4c' # R
  depends_on 'iso_codes' => :build
  depends_on 'libxml2' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'ncurses' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  gnome

  meson_options '-Dgtk_doc=false -Dtests=false'
end
