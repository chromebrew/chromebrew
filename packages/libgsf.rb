require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.50'
  license 'GPL-2 and LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3387aaef57bb436bc10337b988cb27a519a7c0625bd4d7922b392bd3bc995dc2',
     armv7l: '3387aaef57bb436bc10337b988cb27a519a7c0625bd4d7922b392bd3bc995dc2',
     x86_64: '291211e57a54c7618c563eb0d94c8940117a498fcdc7f5520e880cf45ce230bb'
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

  gnome

  configure_options '--enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection'
end
