require 'buildsystems/cmake'

class Gspell < CMake
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.12.2-f3c1eed'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gspell.git'
  git_hashtag 'f3c1eed397751b3af88b841fcdb52199a13dccd5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77a4e9f9e28dd49e56f1b00ab7957619683091b8edd515f530312a57def70d0d',
     armv7l: '77a4e9f9e28dd49e56f1b00ab7957619683091b8edd515f530312a57def70d0d',
     x86_64: 'd3b25c41bc7d13a792af74d1849a110354d131c3c1d94a936b754c11aa0318e9'
  })

  depends_on 'aspell' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'enchant' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hunspell' # L
  depends_on 'icu4c' # R
  depends_on 'iso_codes' => :build
  depends_on 'libxml2' => :build
  depends_on 'llvm18_lib' => :build
  depends_on 'ncurses' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  gnome
end
