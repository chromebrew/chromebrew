require 'buildsystems/meson'

class Tinysparql < Meson
  description 'Low-footprint RDF triple store library with SPARQL 1.1 interface'
  homepage 'https://gitlab.gnome.org/GNOME/tinysparql'
  version '3.7.3-icu75.1'
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url 'https://gitlab.gnome.org/GNOME/tinysparql.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3f8f29edc37a90de375a4c803684f059ab66ee291bc6dc0f80394d3a678d1a0',
     armv7l: 'f3f8f29edc37a90de375a4c803684f059ab66ee291bc6dc0f80394d3a678d1a0',
     x86_64: '26e3149df2d260e96f70c11e5f0e2b7aaed38fbc6545df7cd9a8262b161dfac1'
  })

  depends_on 'asciidoc' => :build
  depends_on 'avahi' # R
  depends_on 'docbook_xml' => :build
  depends_on 'dbus' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' # R
  depends_on 'json_glib' # R
  depends_on 'libsoup2' # R
  depends_on 'libsoup' # R
  depends_on 'libstemmer' # R
  depends_on 'libxml2' # R
  depends_on 'pygobject' => :build
  depends_on 'sqlite' # R
  depends_on 'util_linux' => :build
  depends_on 'vala' => :build

  gnome

  meson_options "-Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Ddocs=false \
      -Dman=false \
      -Dsystemd_user_services=false"
end
