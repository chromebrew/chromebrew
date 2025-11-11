require 'buildsystems/meson'

class Geocode_glib2 < Meson
  description 'Helper library for geocoding services'
  homepage 'https://gitlab.gnome.org/GNOME/geocode-glib'
  version '3.26.4-1'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/geocode-glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fd9186d7d441749380037ebed0834130a15fea63cde6ee4eb666f75e25cdd45',
     armv7l: '5fd9186d7d441749380037ebed0834130a15fea63cde6ee4eb666f75e25cdd45',
     x86_64: '82acd2827696f158d3638ab49fad99221ceb2570d4104c9feb9ff94c59a52bad'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib'
  depends_on 'libsoup' # R
  depends_on 'py3_pygments' => :build

  gnome

  meson_options '-Denable-installed-tests=false -Denable-gtk-doc=false -Dsoup2=false'

  def self.patch
    system "sed -i 's/gnome/Adwaita/' icons/meson.build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    # Conficts with geocode_glib
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/icons"
  end
end
