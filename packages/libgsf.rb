require 'buildsystems/autotools'

class Libgsf < Autotools
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version "1.14.52-634340d-#{CREW_ICU_VER}"
  license 'GPL-2 and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag '634340d31177c02ccdb43171e37291948e7f8974'
  # git_hashtag "LIBGSF_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b1733aadf3d130e5838417b8ed0c1be4612292c6e3cd091d95779a0b3cbf3de',
     armv7l: '1b1733aadf3d130e5838417b8ed0c1be4612292c6e3cd091d95779a0b3cbf3de',
     x86_64: '39d75477e83bbfe3b0c595eb98acb2059212dd1bbafd340462f8d783f7e33304'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :executable_only
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'zlib' # R

  gnome

  autotools_configure_options '--enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection'
end
