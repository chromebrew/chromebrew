require 'buildsystems/autotools'

class Gspell < Autotools
  description 'a flexible API to implement the spell checking in a GTK+ application'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.12.2-87b8146'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gspell.git'
  git_hashtag '87b8146864a130bc1c85c57baa211df160ae564c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb9f5a0b0d0dd27050ec4d953c648cc87c47610ca19968eebfedc699e417e998',
     armv7l: 'eb9f5a0b0d0dd27050ec4d953c648cc87c47610ca19968eebfedc699e417e998',
     x86_64: '3350a5e32bfe4783f680aa54091072f2955824f1271de4336678d519a02c947c'
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
