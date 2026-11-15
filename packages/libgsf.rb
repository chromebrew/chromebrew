require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.60'
  license 'GPL-2 and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55f342daffb78b59a4abd77c8d5e1c4e789fe628aa96d25216ee03659783b76a',
     armv7l: '55f342daffb78b59a4abd77c8d5e1c4e789fe628aa96d25216ee03659783b76a',
     x86_64: '4b3617fb8d2582abc1a334f94b778512169b4cb9cd57dcd1ccbcaa2abbd7e303'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
