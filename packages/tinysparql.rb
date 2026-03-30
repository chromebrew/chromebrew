require 'buildsystems/meson'

class Tinysparql < Meson
  description 'Low-footprint RDF triple store library with SPARQL 1.1 interface'
  homepage 'https://gitlab.gnome.org/GNOME/tinysparql'
  version "3.11.0-#{CREW_ICU_VER}"
  license 'GPLv2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/tinysparql.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b403a9e1bd2fa5236222b26716e0ba8e4133dddfb9ab2a96f236179688b9f16',
     armv7l: '4b403a9e1bd2fa5236222b26716e0ba8e4133dddfb9ab2a96f236179688b9f16',
     x86_64: '3961456e657c11f9a123ecb58004b2295d117df2e6122eee7c8f005a10bf8504'
  })

  depends_on 'avahi' => :library
  depends_on 'dbus' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
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
