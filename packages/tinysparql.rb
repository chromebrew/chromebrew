require 'buildsystems/meson'

class Tinysparql < Meson
  description 'Low-footprint RDF triple store library with SPARQL 1.1 interface'
  homepage 'https://gitlab.gnome.org/GNOME/tinysparql'
  version "3.12.0-#{CREW_ICU_VER}"
  license 'GPLv2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/tinysparql.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7114014559208317503dfe7ec214c8c35b3ddc242a445132943763ff5d6ddb06',
     armv7l: '7114014559208317503dfe7ec214c8c35b3ddc242a445132943763ff5d6ddb06',
     x86_64: '94ea8c376db23c33487dcd755783f32f47a13417f53c0d75547cfe6df11266cf'
  })

  depends_on 'avahi' => :library
  depends_on 'dbus' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' => :library
  depends_on 'json_glib' => :library
  depends_on 'libsoup' => :library
  depends_on 'libstemmer' => :library
  depends_on 'libxml2' => :library
  depends_on 'py3_asciidoc' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'sqlite' => :library
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
