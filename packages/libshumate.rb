# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.0.1'
  license 'LGPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate/-/archive/1.0.1/libshumate-1.0.1.tar.bz2'
  source_sha256 '004188509189eab352b8f86701cec223c15c8fa52b1e0cf5379877725a1e9014'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f52fac3cb098d9048580df930016a6fa597e29140eb1680c34d38b98bfd74fb2',
     armv7l: 'f52fac3cb098d9048580df930016a6fa597e29140eb1680c34d38b98bfd74fb2',
     x86_64: '47f61acf76edf10e4e127efe5ba0b3b40781540ce14b5df35a0b28e0d514254d'
  })

  depends_on 'gtk4'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsoup' # R
  depends_on 'sqlite' # R

  gnome
end
