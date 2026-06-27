require 'buildsystems/meson'

class Gspell < Meson
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version "1.14.4-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gspell.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '852d48ba805102dfd1b9e329cf01cdf7d5eb4bb3b8e4de1aa36a533c03b12a13',
     armv7l: '852d48ba805102dfd1b9e329cf01cdf7d5eb4bb3b8e4de1aa36a533c03b12a13',
     x86_64: '257be3c6fa715135dabf9fb0247a2da200375943a332007f13b0a6847815a8a8'
  })

  depends_on 'aspell' => :build
  depends_on 'autoconf_archive' => :build
  depends_on 'enchant' => :library
  depends_on 'gcc_lib' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' => :library
  depends_on 'hunspell' => :logical
  depends_on 'icu4c' => :library
  depends_on 'iso_codes' => :build
  depends_on 'libxml2' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'ncurses' => :build
  depends_on 'pango' => :library
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgobject_introspection=false \
                 -Dgtk_doc=false \
                 -Dtests=false \
                 -Dvapi=false'
end
