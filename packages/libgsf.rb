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
    aarch64: '4dafa24252971d9206babe036467102a65ed26bff990e06ed6a95779c00c93fe',
     armv7l: '4dafa24252971d9206babe036467102a65ed26bff990e06ed6a95779c00c93fe',
     x86_64: '1a3cd786788e74a9c3c58cdb8469370ecbcd727e95a8442bfa8fce66df69262d'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :executable
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
