require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.61'
  license 'GPL-2 and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec6374c0bbcd502bf57811dd06f1a13b45d3e4bbf772d743a7dc92d51dbe73b2',
     armv7l: 'ec6374c0bbcd502bf57811dd06f1a13b45d3e4bbf772d743a7dc92d51dbe73b2',
     x86_64: '9d840268bbabacab1289c466d5f41108cd9c98f9545a4e362eed47194e2e5226'
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
