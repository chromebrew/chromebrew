require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.58'
  license 'GPL-2 and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '653a448470c28b6ed48d0e5d5e8f322e6c7ae848972764329228324c20ea72f0',
     armv7l: '653a448470c28b6ed48d0e5d5e8f322e6c7ae848972764329228324c20ea72f0',
     x86_64: 'b0883820306e1c43e32f358f6050decad68b675c8e291c65d164f41176d4d83e'
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
