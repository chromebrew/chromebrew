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
    aarch64: 'bf5545a06b87dcfe050261ec24f2d4bde2e171fc9738888d37da71010bbcc618',
     armv7l: 'bf5545a06b87dcfe050261ec24f2d4bde2e171fc9738888d37da71010bbcc618',
     x86_64: '55290360c18f65034004fb5e4f747e034fbbcb04ce7705134bc654820bd0b9fc'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'zlib' # R

  gnome

  autotools_configure_options '--enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection'
end
