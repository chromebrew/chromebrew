require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.58'
  license 'GPL-2 and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag '634340d31177c02ccdb43171e37291948e7f8974'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29cb237c54636c5f6b216dd7d54f8c1f03a18cbffd904529872e669e43cba47d',
     armv7l: '29cb237c54636c5f6b216dd7d54f8c1f03a18cbffd904529872e669e43cba47d',
     x86_64: '56074ce1254dd7275a4bfc71ccc223d8ff68635d14dd4d9935a00dd48b001ecc'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' => :build
  depends_on 'libxml2' => :library
  depends_on 'zlib' => :library

  gnome

  autotools_configure_options '--enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection'
end
