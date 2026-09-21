require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.59'
  license 'GPL-2 and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e17df405f5d3a28eb09cec89517e7780fcc2b0311443293629f91c32eb8cb98d',
     armv7l: 'e17df405f5d3a28eb09cec89517e7780fcc2b0311443293629f91c32eb8cb98d',
     x86_64: '0967f27636f681725bef155829d7710a477ed69eaa1ad080545408590c5517e3'
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
