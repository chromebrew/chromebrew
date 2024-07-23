require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.52'
  license 'GPL-2 and LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ec63a99914ca5a6f52e5c6d7f7a7d2cd7c3a4468276aae62caa11e5b889aa61',
     armv7l: '3ec63a99914ca5a6f52e5c6d7f7a7d2cd7c3a4468276aae62caa11e5b889aa61',
     x86_64: 'a50aaef9c124b5e0b3448d819c21731c05566d0c56a3d9fc29f1bbfd4a7fb74c'
  })

  depends_on 'gdk_pixbuf' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' # R
  depends_on 'gdk_pixbuf' # R

  gnome

  configure_options '--enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection'
end
