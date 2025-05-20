require 'buildsystems/meson'

class Tinysparql < Meson
  description 'Low-footprint RDF triple store library with SPARQL 1.1 interface'
  homepage 'https://gitlab.gnome.org/GNOME/tinysparql'
  version "3.8.0-#{CREW_ICU_VER}"
  license 'GPLv2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/tinysparql.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e977fea317593b02f0f48bd0eec0fd88a148586252c528b29117d8e92ff9ce9a',
     armv7l: 'e977fea317593b02f0f48bd0eec0fd88a148586252c528b29117d8e92ff9ce9a',
     x86_64: 'd9daf173a50f973b42d6145090b6710fd0289379be1d6d30ed9c4c9ea14c0e8b'
  })

  depends_on 'avahi' # R
  depends_on 'dbus' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
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
  depends_on 'py3_asciidoc' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'sqlite' # R
  depends_on 'util_linux' => :build
  depends_on 'vala' => :build

  gnome

  meson_options "-Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Ddocs=false \
      -Dman=false \
      -Dsystemd_user_services=false"

  def self.patch
    return unless Gem::Version.new(LIBC_VERSION.to_s) < Gem::Version.new('2.37') && %w[aarch64 armv7l].include?(ARCH)

    system "sed -i '/Get an appropriate 4-digit year modifier for strftime/,/^endif/d' meson.build"
    system "sed -i \"s/year_modifier/'%4Y'/g\" meson.build"
  end
end
